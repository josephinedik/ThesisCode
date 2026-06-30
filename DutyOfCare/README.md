# ICAIL2025

## Clingo & Python versions used: 
clingo version 5.4.0
Address model: 64-bit

libclingo version 5.4.0
Configuration: with Python 3.6.7, without Lua

libclasp version 3.3.5 (libpotassco version 1.1.0)
Configuration: WITH_THREADS=1
Copyright (C) Benjamin Kaufmann

License: The MIT License <https://opensource.org/licenses/MIT>

## How to generate the results
The results of section 7.1 can be generated using the following command:

`clingo Table1.lp Table2.lp Table3.lp Table4.lp Table5.lp` 

The results of section 7.2 can be generated using the following command:

`clingo Table1.lp Table2.lp Table3.lp Table4.lp Table5.lp Case1.lp`

The results of section 7.3 can be generated using the following command:

`clingo Table1.lp Table2.lp Table3.lp Table4.lp Table5.lp Case2.lp`

The scalability results can be generated using the following command: 

`clingo Table1.lp Table2.lp Table3.lp Table4.lp Table5.lp Scalability.lp`



