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

---
---

# My work

| A | B | C | Number of 1's | N1 | N0 |
|---|---|---|--------------|----|----|
| 0 | 0 | 0 | 0            | 0  | 0  |
| 0 | 0 | 1 | 1            | 0  | 1  |
| 0 | 1 | 0 | 1            | 0  | 1  |
| 0 | 1 | 1 | 2            | 1  | 0  |
| 1 | 0 | 0 | 1            | 0  | 1  |
| 1 | 0 | 1 | 2            | 1  | 0  |
| 1 | 1 | 0 | 2            | 1  | 0  |
| 1 | 1 | 1 | 3            | 1  | 1  |

#### Explanation of Conditions:
- If no 1's in ABC (first row): N1 = 0, N0 = 0
- If one 1 in ABC (rows 2, 3, 5): N1 = 0, N0 = 1
- If two 1's in ABC (rows 4, 6, 7): N1 = 1, N0 = 0
- If three 1's in ABC (last row): N1 = 1, N0 = 1






| A | B | C | A•B | B•C | A•C | N1 | N0 | Condition |
|---|---|---|-----|-----|-----|-----|-----|------------|
| 0 | 0 | 0 | 0   | 0   | 0   | 0   | 0   | No 1's     |
| 0 | 0 | 1 | 0   | 0   | 0   | 0   | 1   | One 1      |
| 0 | 1 | 0 | 0   | 0   | 0   | 0   | 1   | One 1      |
| 0 | 1 | 1 | 0   | 1   | 0   | 1   | 0   | Two 1's    |
| 1 | 0 | 0 | 0   | 0   | 0   | 0   | 1   | One 1      |
| 1 | 0 | 1 | 0   | 0   | 1   | 1   | 0   | Two 1's    |
| 1 | 1 | 0 | 1   | 0   | 1   | 1   | 0   | Two 1's    |
| 1 | 1 | 1 | 1   | 1   | 1   | 1   | 1   | Three 1's  |

#### Logical Functions:
- N1 = A•B + B•C + A•C  (where • represents AND)
- N0 = (A'B'C') + (A'B'C) + (A'BC') + (AB'C')

# Breakdown
Lets think of N1 and N0 as 2 seperate subcircuits to start

# N1

N1 = (A XOR B) XOR C

## Truth Table
Let A, B, and C be the three inputs. 
The truth table for the desired logic circuit is:

| A | B | C | Output |
|---|---|---|--------|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 1 |
| 0 | 1 | 0 | 1 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 0 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 1 |

## Karnaugh Map
We can solve this using a 3-variable Karnaugh map:

     BC
  A  00 01 11 10
   0   0   1   0   1
   1   1   0   0   1

## Boolean Expression
The simplified boolean expression is:

F = (A ⊕ B ⊕ C)

This is an XOR (exclusive OR) operation across all three inputs.

## Logic Gate Implementation
We can implement this using XOR gates:

1. Use two 2-input XOR gates
2. The first XOR gate takes inputs A and B
3. The second XOR gate takes the output of the first XOR gate and input C

### Pseudocode
```
output = (A XOR B) XOR C
```

## Implementations

### Using Standard Logic Gates
1. First XOR gate: f1 = A ⊕ B
2. Second XOR gate: output = f1 ⊕ C

### Using NAND Gates (Universal Gate)
This can also be implemented using only NAND gates, though the circuit would be more complex.

## Simulation Notes
- When exactly one input is high, the output is high
- When all inputs are high, the output is also high
- When zero or two inputs are high, the output is low

# N2

N2 =1 = (A AND B) OR (A AND C) OR (B AND C)

# 3-Input Logic Circuit Design

## Truth Table
| A | B | C | Output |
|---|---|---|--------|
| 0 | 0 | 0 | 0 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 1 |
| 1 | 0 | 0 | 0 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 1 |
| 1 | 1 | 1 | 1 |

## Key Observations
- Output is HIGH when:
  1. Two inputs are HIGH (A=1, B=1, C=0)
  2. Three inputs are HIGH (A=1, B=1, C=1)
- Output is LOW when:
  1. No inputs are HIGH (A=0, B=0, C=0)
  2. Only one input is HIGH

## Boolean Expression
The boolean expression can be derived as:
F = (A AND B) OR (A AND C) OR (B AND C)

This ensures the output is HIGH when two or more inputs are HIGH.

## Minimal Gate Implementation
This can be implemented using 3 two-input AND gates followed by a 3-input OR gate.


# Other Resources

- https://www.allaboutcircuits.com/textbook/digital/chpt-3/cmos-gate-circuitry/
