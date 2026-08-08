# Board results (miner host + deploy)


## Performance

| Kernel | Hardware (PL) | Software (4x A53) | Speedup |
|---|---|---|---|
| Baseline v1 | 0.79 MH/s | 0.79 MH/s | ~1x |
| Optimised v2 | 30.3 MH/s | 0.79 MH/s | 38x |

The baseline kernel runs at about the same speed as the four-thread software, so
on its own it is no faster. The optimised kernel is 38 times faster than the
software baseline.

## Energy

Power comes from the board's own INA260 sensor, read while each kernel was mining.
Efficiency is hashes per joule, which is the hash rate divided by the power.

Power draw:

| State | Power |
|---|---|
| Idle | 3.45 W |
| Baseline v1 kernel (PL) | 3.51 W |
| Optimised kernel (PL) | 4.15 W |
| Software 4-thread (A53) | 4.32 W |

Efficiency:

| | Hash rate | Power | Efficiency | Energy per hash |
|---|---|---|---|---|
| Software (4x A53) | 0.79 MH/s | 4.32 W | 0.184 MH/J | 5.44 uJ |
| Baseline v1 (PL) | 0.79 MH/s | 3.51 W | 0.224 MH/J | 4.46 uJ |
| Optimised (PL) | 30.3 MH/s | 4.15 W | 7.30 MH/J | 137 nJ |

The optimised kernel is about 40 times more energy efficient than the software
baseline. It even draws a little less power than the four-thread software (4.15 W
against 4.32 W) while doing 38 times the work.
