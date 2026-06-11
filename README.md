# AES-256 Hardware Accelerator (VHDL)

A synthesizable VHDL implementation of the **AES** block cipher, provided in **two
architectures** — an area-efficient *iterative* core and a high-throughput
*fully-pipelined* core. The design is parameterizable for **AES-128 / 192 / 256**
(defaults to AES-256) and is verified against **400 known-answer test vectors**.

![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Language: VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)
![Verification](https://img.shields.io/badge/KAT-400%2F400%20passing-brightgreen.svg)

---

## Highlights

- **Two architectures** of the same cipher, sharing the same building blocks:
  - **Iterative** — a single round datapath reused over 14 cycles. Compact, low area.
  - **Fully-pipelined** — one register stage per round (~15 stages deep), so a new
    128-bit block can be accepted on every clock cycle once the pipeline is filled.
- **Parameterizable key size** via the generic `N` (128 / 192 / 256); the controller
  holds the matching round count and RCON schedule for each.
- **LUT-based S-box**, GF(2⁸) MixColumns, on-the-fly key expansion.
- **Thorough verification:** a self-checking testbench runs 400 known-answer vectors
  with automatic PASS/FAIL counting, backed by 15 per-module unit testbenches.

---

## Repository structure

```
AES_HARDWARE/
├── AES-256_Iterative/        # Area-efficient core (round datapath reused)
│   ├── rtl/                  # AES, Controller, KeyExpansion, MainRound, MUXes, ...
│   └── tb/                   # AES_tb
├── AES-256_FullyPipelined/   # High-throughput core (one stage per round)
│   ├── rtl/                  # AES_Fully_Pipelined, InitialRound, Round1, FinalRound, ...
│   └── tb/                   # AES_Fully_Pipelined_tb, AES_SelfTest, kat_256_constants
├── tb_unit_common/           # Per-module unit testbenches (S_BOX, MixColumns, ...)
└── reports/                  # Timing & utilization reports  (add yours here)
```

---

## Results

> Fill these in from the timing and utilization reports (`reports/`).
> The two architectures trade area against throughput — the table makes that explicit.

| Metric                | Iterative      | Fully-Pipelined |
|-----------------------|----------------|-----------------|
| Target device         | `<device>`     | `<device>`      |
| Toolchain             | `<Vivado ...>` | `<Vivado ...>`  |
| Max frequency (Fmax)  | `<MHz>`        | `<MHz>`         |
| Latency               | 14 cycles/block| ~15 cycles (fill) |
| Throughput            | `<Gbps>`       | `<Gbps>`        |
| LUTs                  | `<n>`          | `<n>`           |
| Flip-flops            | `<n>`          | `<n>`           |

Throughput reference:
- **Iterative:** `(128 / 14) × Fmax` bits/s — one block every 14 cycles.
- **Fully-pipelined:** `128 × Fmax` bits/s — one block per cycle after fill.

---

## Architecture

Both cores share the same round transformation — SubBytes → ShiftRows → MixColumns →
AddRoundKey — with the final round omitting MixColumns.

- **S-box:** combinational LUT (256-entry).
- **MixColumns:** GF(2⁸) multipliers (`GF2_Mul` / `Columns_Mul`).
- **Key expansion:** on-the-fly, driven by the controller's RCON schedule.
- **Iterative core:** a counter-driven FSM (`Controller`) feeds the state and round key
  back through the round datapath for 14 iterations, then asserts `FINAL_ROUND`.
- **Pipelined core:** the round instances are chained, each followed by text/key
  registers, so 14 independent blocks can be in flight simultaneously.

<!-- A block diagram here helps a lot for a portfolio — drop a PNG/SVG in reports/ or docs/
     and reference it:  ![Architecture](reports/architecture.png) -->

---

## Verification

The pipelined core is validated by **`AES_SelfTest.vhd`**, which streams **400
known-answer test (KAT) vectors** (`kat_256_constants.vhd`, generated from a JSON
vector set) through the DUT, accounts for the pipeline latency, and compares each
output against the expected ciphertext — incrementing PASS/FAIL counters and reporting
any mismatch with expected-vs-got values.

In addition, **`tb_unit_common/`** contains standalone testbenches for every building
block — S-box, SubBytes, ShiftRows, MixColumns, AddRoundKey, GF(2) multiply,
KeyExpansion(Core), Controller, InitialRound, Round1, FinalRound, MainSteps and the
registers — so each module is checked in isolation before integration.

### Running the self-test (example, GHDL)

```bash
cd AES-256_FullyPipelined
ghdl -a rtl/*.vhd tb/kat_256_constants.vhd tb/AES_SelfTest.vhd
ghdl -e AES_SelfTest
ghdl -r AES_SelfTest
```

---

## License

Released under the [MIT License](LICENSE). AES is a public standard (FIPS-197);
this is an independent implementation.

---

## Author

**Marouane Kouzi** — `<link to your GitHub / LinkedIn>`

If you use this work academically, you can cite it as:

```
Marouane Kouzi, "AES-256 Hardware Accelerator (VHDL)", 2026.
GitHub: https://github.com/<user>/<repo>
```
