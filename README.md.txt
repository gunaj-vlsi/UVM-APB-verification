# UVM-Based Functional Verification of AMBA APB Protocol

## 📌 Project Overview

This project implements a **UVM-based functional verification environment** for verifying an **AMBA APB (Advanced Peripheral Bus) protocol** slave design.

The verification environment is developed using **SystemVerilog and UVM** and simulated using **QuestaSim**.

## 🎯 Objective

The main objective of this project is to verify the functionality and protocol behavior of an APB slave by generating and monitoring different APB transactions.

The testbench verifies:

- APB Write transactions
- APB Read transactions
- Address and data transfer
- APB control signals
- Transaction-level checking
- Expected vs actual data comparison

## 🏗️ UVM Verification Architecture

The verification environment consists of the following UVM components:

- **Sequence** – Generates APB transactions
- **Sequencer** – Sends transactions to the driver
- **Driver** – Converts transactions into APB signal activity
- **Monitor** – Observes APB interface signals
- **Agent** – Contains the driver, sequencer and monitor
- **Scoreboard** – Compares expected and actual results
- **Environment** – Integrates the UVM components
- **Test** – Controls the overall verification scenario

### Verification Flow

```text
Sequence
    ↓
Sequencer
    ↓
Driver
    ↓
APB Interface
    ↓
DUT (APB Slave)
    ↓
Monitor
    ↓
Scoreboard
    ↓
PASS / FAIL