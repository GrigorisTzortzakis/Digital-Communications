# Huffman Coding & DPCM Compression Techniques

## Overview

This project demonstrates two important data compression techniques: **Huffman Coding** for image compression and **Differential Pulse Code Modulation (DPCM)** for signal compression. These methods are crucial in **digital communications** and **information theory**, with applications in optimizing data transmission and storage.

---

## Technologies Used
- **MATLAB**: For algorithm implementation and analysis.

---

## Part A: Huffman Coding

In this section, **Huffman Coding** is applied to an image to reduce its size while preserving data integrity. Various compression metrics, such as entropy and efficiency, are calculated.

### Tasks:
1. **Huffman Coding Implementation**:
   - Compute the entropy, average code length, and compression efficiency of the image.
2. **Second-Order Extension**:
   - Perform second-order extension and compare it to the original coding.
3. **Binary Symmetric Channel Simulation**:
   - Simulate the encoded sequence transmission through a **Binary Symmetric Channel (BSC)** and calculate transmission errors and mutual information.

---

## Part B: Differential Pulse Code Modulation (DPCM)

In Part B, **DPCM** is applied to a signal sequence, allowing for signal compression with reduced prediction error.

### Tasks:
1. **DPCM System Implementation**:
   - Apply DPCM with different predictor values and quantization levels to compress the signal.
2. **Signal Reconstruction**:
   - Compare the original and compressed signals to assess reconstruction quality.
3. **Error Analysis**:
   - Calculate the **Mean Squared Error (MSE)** to evaluate compression performance.

---

## Required Files

To complete this project, the following files are required:

- **Image File**:
  - `parrot.png`: The image used for Huffman coding in Part A.

- **Signal Data Files**:
  - `source.mat`: The source signal used for the DPCM tasks in Part B.
  - `binary.mat`: Simulates the Binary Symmetric Channel for the Huffman coding tasks.

Ensure these files are in the correct directory before starting the tasks.
