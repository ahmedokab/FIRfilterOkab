# FIR Filter in Verilog with Python Simulation by Ahmed Okab!


This project implements an **8-tap finite impulse response (FIR) filter** in Verilog, validating it using a Python testbench pipeline. The design demonstrates how to produce a working digital signal processing (DSP) system, helping me learn alot on how to manage Verilog code, python libraries, and also making testbenches in verilog!

---


## 🧩 Project Structure

- **`fir_filter.v`** – 8-tap moving average FIR filter (parameterized, signed arithmetic).  
- **`testbench1.v`** – Testbench that loads input samples from a file, drives the DUT, and writes filtered results.  
- **`startcode.py`** – Python script that generates a noisy sinusoidal (sine-type curve) test signal, quantizes it, writes `input.data`, reads back `saved.data`, converts fixed-point numbers, + plots the results.  

---

## 📊 Results

The final output plot shows:
<img width="990" height="490" alt="image" src="https://github.com/user-attachments/assets/759d191e-7468-4cc2-ab0b-b96e90bcec18" />
- **Blue:** Noisy test waveform (Python float).  
- **Orange:** Cleaned, smoothed FIR output ( due to Verilog).  

As you can see FIR filter works as designed. BUT there is a delay due to it being an 8 tab filter, output value depending on previous values lol. However, the data is smooth as intended.

---



---
##  Skills Demonstrated

This project has helped me gain many skills such as:

- Digital signal processing (FIR filter design).  
- Verilog RTL coding and testbenching.  
- Fixed-point representation and scaling.   
- Python-based verification with NumPy and Matplotlib.  


---



---


