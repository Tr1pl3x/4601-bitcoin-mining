// host.cpp
#include <xrt/xrt_bo.h>
#include <xrt/xrt_device.h>
#include <xrt/xrt_kernel.h>

#include <array>
#include <chrono>
#include <cctype>
#include <cerrno>
#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <iomanip>
#include <iostream>
#include <limits>
#include <stdexcept>
#include <string>
#include <string_view>

namespace {
constexpr std::array<std::uint32_t, 64> K = {
0x428a2f98U,0x71374491U,0xb5c0fbcfU,0xe9b5dba5U,0x3956c25bU,0x59f111f1U,0x923f82a4U,0xab1c5ed5U,
0xd807aa98U,0x12835b01U,0x243185beU,0x550c7dc3U,0x72be5d74U,0x80deb1feU,0x9bdc06a7U,0xc19bf174U,
0xe49b69c1U,0xefbe4786U,0x0fc19dc6U,0x240ca1ccU,0x2de92c6fU,0x4a7484aaU,0x5cb0a9dcU,0x76f988daU,
0x983e5152U,0xa831c66dU,0xb00327c8U,0xbf597fc7U,0xc6e00bf3U,0xd5a79147U,0x06ca6351U,0x14292967U,
0x27b70a85U,0x2e1b2138U,0x4d2c6dfcU,0x53380d13U,0x650a7354U,0x766a0abbU,0x81c2c92eU,0x92722c85U,
0xa2bfe8a1U,0xa81a664bU,0xc24b8b70U,0xc76c51a3U,0xd192e819U,0xd6990624U,0xf40e3585U,0x106aa070U,
0x19a4c116U,0x1e376c08U,0x2748774cU,0x34b0bcb5U,0x391c0cb3U,0x4ed8aa4aU,0x5b9cca4fU,0x682e6ff3U,
0x748f82eeU,0x78a5636fU,0x84c87814U,0x8cc70208U,0x90befffaU,0xa4506cebU,0xbef9a3f7U,0xc67178f2U};

constexpr std::array<std::uint32_t, 8> H0 = {
0x6a09e667U,0xbb67ae85U,0x3c6ef372U,0xa54ff53aU,
0x510e527fU,0x9b05688cU,0x1f83d9abU,0x5be0cd19U};

std::uint32_t rotr(std::uint32_t x, unsigned n){return (x>>n)|(x<<(32U-n));}
std::uint32_t load_be32(const std::uint8_t* p){
    return (std::uint32_t(p[0])<<24)|(std::uint32_t(p[1])<<16)|
           (std::uint32_t(p[2])<<8)|std::uint32_t(p[3]);
}

void sha256_compress_host(std::array<std::uint32_t,8>& state,const std::uint8_t block[64]){
    std::array<std::uint32_t,64> w{};
    for(int i=0;i<16;++i) w[i]=load_be32(block+i*4);
    for(int i=16;i<64;++i){
        auto a=w[i-15],b=w[i-2];
        auto s0=rotr(a,7)^rotr(a,18)^(a>>3);
        auto s1=rotr(b,17)^rotr(b,19)^(b>>10);
        w[i]=w[i-16]+s0+w[i-7]+s1;
    }
    auto a=state[0],b=state[1],c=state[2],d=state[3];
    auto e=state[4],f=state[5],g=state[6],h=state[7];
    for(int i=0;i<64;++i){
        auto S1=rotr(e,6)^rotr(e,11)^rotr(e,25);
        auto ch=(e&f)^(~e&g);
        auto t1=h+S1+ch+K[i]+w[i];
        auto S0=rotr(a,2)^rotr(a,13)^rotr(a,22);
        auto maj=(a&b)^(a&c)^(b&c);
        auto t2=S0+maj;
        h=g; g=f; f=e; e=d+t1; d=c; c=b; b=a; a=t1+t2;
    }
    state[0]+=a; state[1]+=b; state[2]+=c; state[3]+=d;
    state[4]+=e; state[5]+=f; state[6]+=g; state[7]+=h;
}

int hexv(char c){
    if(c>='0'&&c<='9') return c-'0';
    if(c>='a'&&c<='f') return c-'a'+10;
    if(c>='A'&&c<='F') return c-'A'+10;
    if(std::isspace(static_cast<unsigned char>(c))) return -2;
    return -1;
}

template<std::size_t N>
std::array<std::uint8_t,N> parse_hex(std::string_view text){
    std::string s;
    for(char c:text){int v=hexv(c); if(v==-2) continue; if(v<0) throw std::invalid_argument("bad hex"); s.push_back(c);}
    if(s.size()!=N*2) throw std::invalid_argument("wrong hex length");
    std::array<std::uint8_t,N> out{};
    for(std::size_t i=0;i<N;++i) out[i]=std::uint8_t((hexv(s[2*i])<<4)|hexv(s[2*i+1]));
    return out;
}

std::uint32_t parse_u32(const char* s){
    char* end=nullptr; errno=0; auto v=std::strtoull(s,&end,0);
    if(errno||end==s||*end!='\0'||v>std::numeric_limits<std::uint32_t>::max())
        throw std::invalid_argument("bad 32-bit integer");
    return std::uint32_t(v);
}
}

int main(int argc,char** argv){
    try{
        if(argc!=6){
            std::cerr<<"Usage: "<<argv[0]<<" <kernel.xclbin> <header_hex_160> <target_hex_64> <nonce_start> <nonce_count>\n";
            return 1;
        }
        const auto header=parse_hex<80>(argv[2]);
        const auto target=parse_hex<32>(argv[3]);
        const auto nonce_start=parse_u32(argv[4]);
        const auto nonce_count=parse_u32(argv[5]);
        if(!nonce_count) throw std::invalid_argument("nonce_count must be > 0");

        std::array<std::uint32_t,8> midstate=H0;
        sha256_compress_host(midstate,header.data());

        std::array<std::uint32_t,3> tail={
            load_be32(header.data()+64),
            load_be32(header.data()+68),
            load_be32(header.data()+72)};
        std::array<std::uint32_t,8> target_words{};
        for(std::size_t i=0;i<8;++i) target_words[i]=load_be32(target.data()+4*i);

        xrt::device device{0};
        auto uuid=device.load_xclbin(argv[1]);
        xrt::kernel kernel{device,uuid,"mine"};

        xrt::bo mid_bo{device,sizeof(midstate),kernel.group_id(0)};
        xrt::bo tail_bo{device,sizeof(tail),kernel.group_id(1)};
        xrt::bo tgt_bo{device,sizeof(target_words),kernel.group_id(2)};
        xrt::bo nonce_bo{device,sizeof(std::uint32_t),kernel.group_id(5)};
        xrt::bo found_bo{device,sizeof(std::int32_t),kernel.group_id(6)};

        std::memcpy(mid_bo.map<std::uint32_t*>(),midstate.data(),sizeof(midstate));
        std::memcpy(tail_bo.map<std::uint32_t*>(),tail.data(),sizeof(tail));
        std::memcpy(tgt_bo.map<std::uint32_t*>(),target_words.data(),sizeof(target_words));
        *nonce_bo.map<std::uint32_t*>()=0;
        *found_bo.map<std::int32_t*>()=0;

        mid_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        tail_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        tgt_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        nonce_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);
        found_bo.sync(XCL_BO_SYNC_BO_TO_DEVICE);

        auto t0=std::chrono::steady_clock::now();
        auto run=kernel(mid_bo,tail_bo,tgt_bo,nonce_start,nonce_count,nonce_bo,found_bo);
        run.wait();
        auto t1=std::chrono::steady_clock::now();

        nonce_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);
        found_bo.sync(XCL_BO_SYNC_BO_FROM_DEVICE);

        auto found=*found_bo.map<std::int32_t*>();
        auto found_nonce=*nonce_bo.map<std::uint32_t*>();
        double sec=std::chrono::duration<double>(t1-t0).count();
        std::uint64_t tested=found?std::uint64_t(found_nonce)-nonce_start+1ULL:nonce_count;

        std::cout<<"found="<<found<<" found_nonce="<<found_nonce<<"\n";
        std::cout<<"kernel_time_s="<<std::fixed<<std::setprecision(6)<<sec<<"\n";
        if(sec>0) std::cout<<"estimated_rate="<<std::setprecision(3)<<(tested/sec/1e6)<<" MH/s\n";
        return 0;
    }catch(const std::exception& e){
        std::cerr<<"Error: "<<e.what()<<"\n";
        return 1;
    }
}