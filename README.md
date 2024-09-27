# Huffman Coding & DPCM Compression Techniques

## Overview

Created for the **UOP CEID department** in the **2023-2024 academic year**.

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
   
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Entropy_code_length.png" width="400px">

2. **Second-Order Extension**:
   - Perform second-order extension and compare it to the original coding.
   
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Entropy_code_length_2ndorder.png" width="400px">

3. **Binary Symmetric Channel Simulation**:
   - Simulate the encoded sequence transmission through a **Binary Symmetric Channel (BSC)** and calculate transmission errors and mutual information.
   
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Binary_symmetric_channel.png" width="400px">

---

## Part B: Differential Pulse Code Modulation (DPCM)

In Part B, **DPCM** is applied to a signal sequence, allowing for signal compression with reduced prediction error.

### Tasks:
1. **DPCM System Implementation**:
   - Apply DPCM with different predictor values and quantization levels to compress the signal.
  <div></div> <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_1.png" width="400px" > </div>
  <div> <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/DPCM.png" width="400px"> </div>

2. **Signal Reconstruction**:
   - Compare the original and compressed signals to assess reconstruction quality and see how the predictor values affect the signal along with different quantization levels.
   
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_2_p%3D12_N%3D1.png" width="400px">
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_2_p%3D12_N%3D2.png" width="400px">
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_2_p%3D12_N%3D3.png" width="400px">
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_4_p%3D5_N%3D2.png" width="400px">

3. **Error Analysis**:
   - Calculate the **Mean Squared Error (MSE)** to evaluate compression performance.
   
   <img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Partb_question_3.png" width="400px">

---

## Instructions

To complete this project, follow the steps below and ensure the required files are correctly placed in the directory.

### 1. Required Files

Before starting, ensure that the following three files are in the directory:

- **Image File**:
  - `parrot.png`: The image used for Huffman coding in Part A.
  
- **Signal Data Files**:
  - `source.mat`: The source signal used for the DPCM tasks in Part B.
  - `binary.mat`: Simulates the Binary Symmetric Channel for the Huffman coding tasks.

You can download these files from [this link](https://github.com/GrigorisTzortzakis/Digital-Communications/tree/main/Project%201/Starting%20files).

### 2. Thought Process and Code Development

The thought process behind the code development for this project can be found in the following links:

- For **Part A** (Information Theory and Huffman Coding):  
  [Part A Thought Process](https://github.com/GrigorisTzortzakis/Digital-Communications/tree/main/Project%201/Theory/Information%20Theory)
  
- For **Part B** (DPCM):  
  [Part B Thought Process](https://github.com/GrigorisTzortzakis/Digital-Communications/tree/main/Project%201/Theory/DPCM)

### 3. Running the Code (Part A)

For **Part A**, the code files need to be executed in sequence, one by one, to ensure that variables are correctly initialized and used later on in the process. Although all scripts can be run in the same MATLAB tab, it is recommended to open each script in separate tabs so that they can be executed one at a time. You can find the code for **Part A** here: [Part A Code](https://github.com/GrigorisTzortzakis/Digital-Communications/tree/main/Project%201/Code/Part%20A).

<img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Sequential_code_execution_explained.png" width="400px">

### Running the Code (Part B)

Similarly, for **Part B**, the files need to be executed in order. The code for Part B can be found here: [Part B Code](https://github.com/GrigorisTzortzakis/Digital-Communications/tree/main/Project%201/Code/Part%20B).

For question 2, the code is included in question 1, otherwise it will not work on its own. Finally, for question 1 you must change the values of p and N manually to see the changes you want.

<img src="https://github.com/GrigorisTzortzakis/Digital-Communications/blob/main/Project%201/pics%20for%20readme/Change_values_by_hand.png" width="400px">
