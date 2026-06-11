# AES-256 Encryption Core (VHDL)

A synthesizable VHDL implementation of the **AES-256 block cipher**, provided in
two architectures — an area-efficient *iterative* core and a high-throughput
*fully-pipelined* core — targeting the **Xilinx Artix-7** FPGA family. Verified
against **400 known-answer test vectors**.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Language: VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)
![KAT](https://img.shields.io/badge/KAT-400%2F400%20passing-brightgreen.svg)
![Device](https://img.shields.io/badge/Device-Artix--7-blue.svg)
![Tool](https://img.shields.io/badge/Tool-Vivado%202023.2-orange.svg)

---

## Two Architectures, One Goal

Both cores implement the same AES-256 cipher (256-bit key, 14 rounds, 128-bit block)
and share the same RTL building blocks — the difference is purely micro-architectural:

| | Iterative | Fully Pipelined |
|---|---|---|
| **Strategy** | Single round datapath, reused 14× | One dedicated hardware stage per round |
| **Latency** | 15 cycles / block | 15 cycles (pipeline fill) |
| **Throughput** | 1 block per 15 cycles | **1 block per cycle** (sustained) |
| **LUT usage** | 2 573 (4.1 %) | 15 360 (24.2 %) |
| **Flip-flops** | 1 029 (0.8 %) | 5 376 (4.2 %) |
| **Fmax** | ≈ 161 MHz | **≈ 214 MHz** |
| **Throughput** | ≈ 1.37 Gbps | **≈ 27.36 Gbps** |
| **Total power** | 0.593 W | 1.497 W |
| **Timing @ 200 MHz** | ❌ FAIL (WNS −1.212 ns) | ✅ PASS (WNS +0.321 ns) |

---

## Benchmark Results

> Target: **Xilinx Artix-7** · Tool: **Vivado 2023.2** ·
> Clock constraint: **200 MHz (5.0 ns)**

### Resource Utilization

| Resource | Available | Iterative | % | Fully Pipelined | % |
|---|---|---|---|---|---|
| Slice LUTs | 63 400 | 2 573 | 4.06 % | 15 360 | 24.23 % |
| Slice Registers | 126 800 | 1 029 | 0.81 % | 5 376 | 4.24 % |
| F7 Muxes | 31 700 | 576 | 1.82 % | 4 416 | 13.93 % |
| F8 Muxes | 15 850 | 280 | 1.77 % | 1 968 | 12.42 % |
| Block RAMs | 135 | 0 | 0 % | 0 | 0 % |
| DSPs | 240 | 0 | 0 % | 0 | 0 % |

Neither design uses BRAMs or DSPs — AES-256 operations (XOR, S-box) are
implemented entirely in LUTs.

### Timing

| Parameter | Iterative | Fully Pipelined |
|---|---|---|
| WNS | −1.212 ns | +0.321 ns |
| WHS | +0.143 ns | +0.038 ns |
| Critical path | 6.075 ns (10 logic levels) | 4.384 ns (7 logic levels) |
| Achievable Fmax | ≈ 161 MHz | ≈ 214 MHz |

The iterative core misses the 200 MHz constraint by 1.212 ns — the critical path runs
through the shared key-expansion path. Adding one pipeline register in that path would
likely resolve the 128 violations with negligible area overhead.

### Performance

| Metric | Iterative | Fully Pipelined |
|---|---|---|
| Latency | 93.18 ns / block | 70.19 ns / block |
| Throughput | ≈ 1.37 Gbps | ≈ 27.36 Gbps |
| Throughput / LUT | 0.534 Mbps / LUT | 1.781 Mbps / LUT |
| Throughput / Power | 2.32 Gbps / W | 18.28 Gbps / W |
| Area × Time | 239 841 LUT·ns | 71 869 LUT·ns |

The pipelined core delivers **~20× more throughput** while achieving **~3.3× better
Throughput/LUT** and **~7.9× better Throughput/Power** ratios.

### Power (synthesized — Low confidence)

| Component | Iterative | Fully Pipelined |
|---|---|---|
| Dynamic | 0.501 W | 1.403 W |
| Static | 0.092 W | 0.094 W |
| **Total** | **0.593 W** | **1.497 W** |

---

## Architecture

Both cores share the same round-transformation building blocks:

- **S-box** — 256-entry combinational LUT (FIPS-197 §5.1.1)
- **MixColumns** — GF(2⁸) column multipliers (`GF2_Mul` / `Columns_Mul`)
- **Key expansion** — on-the-fly, driven by a RCON schedule in the `Controller`

**Iterative core (`AES`):** a counter-driven FSM reuses a single
SubBytes→ShiftRows→MixColumns→AddRoundKey datapath over 14 clock cycles.
MUX and MUXK route state and key feedback. Compact, minimal area.



**Pipelined core (`AES_Fully_Pipelined`):** 14 round stages chained in hardware —
InitialRound → 12× Round1 → FinalRound — each separated by text/key pipeline
registers (~27 registers total). One new 128-bit block enters per clock cycle once
the pipeline is filled.

---

## Repository Structure

```
aes256-vhdl/
├── AES-256_Iterative/
│   ├── rtl/          # AES, Controller, KeyExpansion, MainRound, MUXes, ...
│   └── tb/           # AES_tb
│   └── reports/      # Vivado timing, utilization, and power reports
├── AES-256_FullyPipelined/
│   ├── rtl/          # AES_Fully_Pipelined, InitialRound, Round1, FinalRound, ...
│   └── tb/           # AES_Fully_Pipelined_tb, AES_SelfTest, kat_256_constants
│   └── reports/      # Vivado timing, utilization, and power reports
└── tb_unit_common/   # 15 per-module unit testbenches
```

---

## Verification

**`AES_SelfTest.vhd`** streams **400 AES-256 known-answer test vectors**
(`kat_256_constants.vhd`) through the pipelined DUT, accounts for the 15-cycle
pipeline latency, and compares every output against the expected ciphertext —
logging PASS/FAIL with expected-vs-got detail on any mismatch.

**`tb_unit_common/`** provides standalone self-checking testbenches for every
building block: S-box, SubBytes, ShiftRows, MixColumns, AddRoundKey, GF(2)
multiplier, KeyExpansion(Core), Controller, InitialRound, Round1, FinalRound,
MainSteps, and the registers.

### Running the self-test (GHDL example)

```bash
cd AES-256_FullyPipelined
ghdl -a rtl/*.vhd tb/kat_256_constants.vhd tb/AES_SelfTest.vhd
ghdl -e AES_SelfTest
ghdl -r AES_SelfTest
```

---

## When to Use Each Architecture

| Use case | Iterative | Pipelined |
|---|---|---|
| High-throughput stream encryption (network, storage) | | ✓ |
| Resource-constrained / small FPGA | ✓ | |
| Low-power IoT / embedded | ✓ | |
| Server / datacenter crypto accelerator | | ✓ |
| Maximum frequency operation | | ✓ |
| Battery-powered devices | ✓ | |

---

## License

Released under the [MIT License](LICENSE).
AES is a public standard (FIPS-197); this is an independent implementation.

---

## Author

**Marouane Kouzi**

If you use this work academically, you can cite it as:

```
Marouane Kouzi, "AES-256 Encryption Core (VHDL)", 2026.
GitHub: https://github.com/Kouz-1/aes256-vhdl
```
