# 🚀 SPI Slave with Single-Port RAM - RTL Design & Implementation 🛠️

## 📖 Project Overview

This repository contains the complete Register-Transfer Level (RTL) design and verification of an SPI Slave interface integrated with a Single-Port RAM. The system enables an external SPI Master device to write data into memory and read data back through a standard SPI communication protocol. The design was implemented in Verilog and verified using QuestaSim, Questa Linting, and Xilinx Vivado.

---

## 🌐 Live Demo

Experience the SPI Slave interface directly in your browser through the interactive simulation:

[![Live Demo](https://img.shields.io/badge/🚀%20Live%20Demo-Open%20SPI%20Simulation-brightgreen?style=for-the-badge)](https://ahmedjouda17.github.io/SPI-SLAVE/)

> **No installation required.**
> Open the live demo to explore the SPI Slave transaction flow and simulation interface directly from your browser.

---

## 🔄 Communication Flow & Transaction Sequence

To understand how the **SPI Master** interacts with our **SPI Slave and Single-Port RAM** architecture, every full transaction follows a strict 2-phase command protocol over the serial lines (`MOSI`, `MISO`, `SS_n`, `CLK`):

### 1️⃣ Write Operation Sequence (Storing Data)

* **Step 1 (Write Address):**

  * The master pulls `SS_n` low and sends the command code `00` followed by the target memory address.
  * The SPI Slave decodes `00`, latches the incoming address, and sets the internal write flag.

* **Step 2 (Write Data):**

  * The master initiates a new frame with command code `01` followed by the 8-bit data payload.
  * The SPI Slave receives the data (`rx_data`) via SIPO (Serial-In Parallel-Out) and writes it directly into the Single-Port RAM at the previously latched address.

### 2️⃣ Read Operation Sequence (Retrieving Data)

* **Step 1 (Read Address):**

  * The master sends command code `10` followed by the target memory address.
  * The SPI Slave decodes the command and latches the read address into the system.

* **Step 2 (Read Data):**

  * The master sends command code `11`.
  * The RAM retrieves the stored byte from the latched address, passes it to the SPI Slave (`tx_data`), and the PISO (Parallel-In Serial-Out) shift register shifts the data bit-by-bit back to_*
