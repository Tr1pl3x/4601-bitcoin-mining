# 2026-08-02T15:12:55.127856349
import vitis

client = vitis.create_client()
client.set_workspace(path="hasitha_optimization")

comp = client.get_component(name="miner_host")
comp.build(target="hw")

client.delete_component(name="miner_host")

comp = client.create_app_component(name="sha256_miner_host",platform = "$COMPONENT_LOCATION/../../kv260_custom/export/kv260_custom/kv260_custom.xpfm",domain = "linux_psu_cortexa53")

comp = client.get_component("sha256_miner_host")

status = comp.set_sysroot(sysroot="/home/cse/Documents/WorkSpaces/vaddWS/xilinx-zynqmp-common-v2025.2/sysroots/cortexa72-cortexa53-amd-linux")

comp = client.get_component(name="sha256_miner_host")
status = comp.import_files(from_loc="", files=["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/host_files/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/host_files/cmdlineparser.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/host_files/logger.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/host_files/logger.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/host_files/sha256_miner_host.cpp"], is_skip_copy_sources = False)

proj = client.get_sys_project(name="miner_system_sha256")

proj = proj.add_component(name="sha256_miner_host")

comp.build(target="hw")

comp.build(target="hw")

comp.build(target="hw")

proj.build_container(target = "hw",build_comps = False, container_name = "miner_binary_container_1")

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["cmdlineparser.cpp", "logger.cpp", "sha256_miner_host.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/dylan-hls/golden.dat"])

status = comp.import_files(from_loc="$COMPONENT_LOCATION/../../dylan-hls", files=["golden.dat"], is_skip_copy_sources = False)

comp.build(target="hw")

proj.build_container(target = "hw",build_comps = False, container_name = "miner_binary_container_1")

proj.build_container(target = "hw",comp_name = ["hasitha_hls_component"],build_comps = False, container_name = "miner_binary_container_1")

