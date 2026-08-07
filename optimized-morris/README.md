# Optimised Bitcoin miner kernel (Morris)

The optimised HLS mining kernel for the KV260. It hashes the 80-byte block
header twice with SHA-256, sweeps the nonce, and reports the first nonce whose
hash is below the target.

Files: `mine.cpp` (kernel), `mine_test.cpp` (C testbench), `golden.dat`
(known-answer vectors), `morris_hls_compile.rpt` (synthesis report).

## Final result

| Metric | Value |
| --- | --- |
| Nonce loop II | 6 |
| Clock | 200 MHz (5 ns) |
| Speed | ~33 MH/s, one core |
| LUT | 55% |
| FF | 15% |
| BRAM | 10% |
| DSP | 0 |
| Timing | met |

The design is board-safe (55% LUT routes with room to spare) and splits the work
the way the project asks: the host computes the one-time midstate, the FPGA does
the per-nonce hashing.

## How it was optimised

Part `xck26-sfvc784-2LV-c`, 200 MHz. II is the nonce-loop interval; speed is
200 MHz divided by II. Each step was one change, checked with C simulation, then
C synthesis.

| Step | Change | II | LUT | Outcome |
| --- | --- | --- | --- | --- |
| Baseline | plain kernel, 3 compressions per nonce | 231 | 58% | starting point |
| 1 | partition the header array | 198 | 156% | did not fit, but showed the SHA compressions are the real cost |
| 2 | midstate: hash block 1 once, 2 compressions per nonce | 137 | 99% | fits, faster |
| 3 | force pipeline II=1 | n/a | n/a | scheduler hung |
| 3.1 | rolling 16-word message schedule | 137 | 137% | timing failed (a changing index becomes big muxes); reverted |
| 3.2 | share one SHA unit, pipeline off | 241 | 93% | lost the overlap, slower; reverted |
| 3.3 | remove the early return from the loop | 4 | 98% | breakthrough: nonces pipeline, ~50 MH/s |
| 4 | move the midstate to the host | 6 | 55% | chosen design: board-safe, correct PS/PL split |
| 5 | unroll the loop by 2 | n/a | 57% | unroll turned the pipeline off; reverted |
| 5.1 | force pipeline II=3 | n/a | n/a | scheduler hung; reverted |
| 6 | partition the hot-path arrays | 6 | 56% | no effect; proved II=6 is not memory-limited; reverted |

## The two ideas that mattered

1. **Midstate (step 2).** The first 64 header bytes never change while the nonce
sweeps, so block 1 is hashed once instead of on every nonce. That cuts three
compressions per nonce down to two.
2. **Remove the early return (step 3.3).** The old loop stopped the moment it
found a winner. That data-dependent exit prevented the tool from overlapping
nonces. Sweeping the whole range and keeping the first winner in a sticky
register let the tool pipeline the loop, and that is where most of the speed
came from.

## Why II=6 is the floor

One SHA engine does two dependent compressions per nonce. A second engine would
roughly double the LUTs and no longer fit (about 110%), and forcing a lower II
makes the scheduler hang. Step 6 (partitioning the arrays) had no effect, which
confirms II=6 is not a memory-port stall. It is the real limit of one engine on
this chip. So II=6 (about 33 MH/s) is the best buildable single-engine design
here, and the next gain would need a bigger FPGA.