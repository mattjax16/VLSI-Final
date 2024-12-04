# EE103 Intro to VLSI Design - Fall 2024

## Project: CMOS Combinational Design and Optimization

### Objective:

- You will design a CMOS combinational circuit, implement it using Synopsys Custom Compiler, and use HSPICE simulation tool to analyze and optimize it.
- **DUE DATE:** December 6, 2024.

---

### Lab Tasks:

- Design a CMOS combinational circuit given the functionality and optimize the delay.

---

### Assignment:

- Design a binary counter and minimize the number of transistors. The circuit details are as follows:

  1. **Inputs:** 3 (A, B, C), each is a 1-bit signal.
  2. **Outputs:** 2 (N1, N0) – used to count the number of signal `1` for inputs.
  3. **Functionality:**

      - If no 1 in ABC:  `N1=0; N0=0`.
      - If one 1 in ABC:  `N1=0; N0=1`.
      - If two 1's in ABC:  `N1=1; N0=0`.
      - If three 1's in ABC:  `N1=1; N0=1`.

- **Implementation Steps:**
  1. Use Synopsys Custom Compiler to implement the circuit.
  2. Set transistor length to 100nm and assign arbitrary widths.
  3. Generate the SPICE netlist.
  4. Verify functionality using HSPICE.
  5. Optimize for delay by adjusting transistor widths.
  6. **Graduate Section:** Add buffers/inverters if needed for optimization.
  7. **Extra Credit:** The fastest delay design earns 2 extra points; the second fastest earns 1 extra point.

---

### Additional Requirements:

1. Circuit must be CMOS.
2. Transistor widths: 300nm to 10000nm.
3. Add a buffer (two inverters in series) to each primary input.
4. Add a load equivalent to 128 times the gate capacitance for each primary output.
5. Minimize the number of transistors in the first stage. Buffers/inverters added later for delay reduction are not counted.
6. Ensure non-skewed gates (fall delay ≈ rise delay).

---

### Submission:

Submit the following:

1. Screenshot of schematic from Synopsys Custom Compiler.
2. Table of transistor names and widths.
3. HSPICE netlist of the circuit (subckt).
4. Screenshots verifying functionality.
5. Steps and techniques for delay optimization.
6. Performance screenshots (worst-case delay).
7. Conclusion and insights.

---

### Grading Criteria:

1. Quality of lab report.
2. Number of transistors used (excluding additional buffers/inverters for delay optimization).
3. Worst-case delay performance.
4. Extra credit eligibility depends on correct worst-case transition measurement and near-optimal transistor count.

