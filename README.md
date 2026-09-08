# 🚀 SPI Slave with Single-Port RAM - RTL Design & Implementation 🛠️

## 📖 Project Overview
This repository contains the complete Register-Transfer Level (RTL) design and verification of an SPI Slave interface integrated with a Single-Port RAM. The system enables an external SPI Master device to write data into memory and read data back through a standard SPI communication protocol. The design was implemented in Verilog and verified using Questasim, Questa Linting, and Xilinx Vivado.

## 🔄 Communication Flow & Transaction Sequence

To understand how the **SPI Master** interacts with our **SPI Slave and Single-Port RAM** architecture, every full transaction follows a strict 2-phase command protocol over the serial lines (`MOSI`, `MISO`, `SS_n`, `CLK`):

### 1️⃣ Write Operation Sequence (Storing Data)
* **Step 1 (Write Address):** 
  * The master pulls `SS_n` low and sends the command code `00` followed by the target memory address.
  * The SPI Slave decodes `00`, latches the incoming address, and sets the internal write flagز
* **Step 2 (Write Data):** 
  * The master initiates a new frame with command code `01` followed by the 8-bit data payload.
  * The SPI Slave receives the data (`rx_data`) via SIPO (Serial-In Parallel-Out) and writes it directly into the Single-Port RAM at the previously latched address

### 2️⃣ Read Operation Sequence (Retrieving Data)
* **Step 1 (Read Address):** 
  * The master sends command code `10` followed by the target memory address.
  * The SPI Slave decodes the command and latches the read address into the system[cite: 2].
* **Step 2 (Read Data):** 
  * The master sends command code `11`.
  * The RAM retrieves the stored byte from the latched address, passes it to the SPI Slave (`tx_data`), and the PISO (Parallel-In Serial-Out) shift register shifts the data bit-by-bit back to the master through the `MISO` line[cite: 2].

## 🏗️ Architecture & Modules
The project is divided into three main modules:
* 🧩 **SPI Slave:** The core communication block that handles protocol timing (MOSI, MISO, SS_n, CLK), decodes commands, and drives the RAM. It is controlled by a Finite State Machine (FSM) with states: IDLE, CHK_CMD, WRITE, READ_ADD, and READ_DATA.
* 💾 **Single-Port RAM:** A 256x8-bit internal data storage element. It allows a single read or write access at a time, controlled entirely by the SPI Slave.
* 🔗 **TOP Module:** Connects the SPI Slave and RAM together and exposes the external SPI interface to the master.

## ⚙️ SPI Command Structure
The SPI Slave decodes a 2-bit command field at the start of each transaction:
* **`00`**: **Write Address** - Latches the incoming address value.
* **`01`**: **Write Data** - Writes the incoming data into RAM at the latched address.
* **`10`**: **Read Address** - Latches the address for a subsequent read.
* **`11`**: **Read Data** - Retrieves data from RAM and transmits it serially via MISO.

## 🔍 Simulation & Verification
The design was thoroughly verified using QuestaSim.
* 🧪 A dedicated testbench was created to verify independent and sequential write/read operations.
* 🔄 Waveforms confirmed the correct end-to-end operation for multiple Write Address → Write Data and Read Address → Read Data transactions without errors.

## 📊 Implementation Results (Xilinx Vivado)
The RTL was fully elaborated, synthesized, and implemented. The following reports were generated for the baseline **Binary Encoded FSM**:

### 1️⃣ Resource Utilization
* 📉 **Slice LUTs:** 29
* 📈 **Slice Registers:** 51
* 🧱 **Block RAM Tile:** 0.5

### 2️⃣ Timing Closure
* ⏱️ All user-specified timing constraints were met.
* ⏳ **Worst Negative Slack (WNS):** 1.448 ns
* ⏲️ **Worst Hold Slack (WHS):** 0.132 ns

### 3️⃣ Power Analysis
* ⚡ **Total On-Chip Power:** 0.06 W
* 🔋 **Dynamic Power:** 0.001 W (2%)
* 🔌 **Device Static Power:** 0.059 W (98%)

## 🔬 FSM Encoding Experiments
Different FSM state encoding styles were synthesized and compared:
* 🔹 **Binary:** Provided a balanced trade-off between area and timing.
* 🔹 **Gray:** Resulted in reduced switching activity and good area efficiency (28 LUTs).
* 🔹 **One-Hot:** Achieved faster timing (WNS: 1.460 ns) but required higher area usage.

## ✨ Code Quality
* 🛡️ The Verilog source code was analyzed using Questa Linting, resulting in NO ERROR.

---
### 👨‍💻 Author
**Ahmed Goda Sharawy**
*🎓 Communication & Electronics Engineering*
