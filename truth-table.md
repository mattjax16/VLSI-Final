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

### Explanation of Conditions:
- If no 1's in ABC (first row): N1 = 0, N0 = 0
- If one 1 in ABC (rows 2, 3, 5): N1 = 0, N0 = 1
- If two 1's in ABC (rows 4, 6, 7): N1 = 1, N0 = 0
- If three 1's in ABC (last row): N1 = 1, N0 = 1
