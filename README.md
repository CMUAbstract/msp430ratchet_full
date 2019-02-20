# Ratchet (OSDI'16) port for MSP430
This is a port of the Ratchet system to WISP5 hardware that uses MSP430FR5969.
The runtime library (libratchet) is not from the author of Ratchet.
The compiler pass (LLVM) is a tweak from the author code.
Additionally, it needs a backend to run, which is written in python (ext/python_dissembler/ratchet_backend.py).

## How to Use:
1. init() and restore_regs() has to be called in the beginning of the main function manually. See the examples (src/). It is not hard to automate it with the compiler, which I simply did not.
2. When declaring global vars, give it an \_\_nv prefix to make it go into the NVM (see src/). If the compiler puts anything in .bss, the system does not work. Alternatively, it can be fixed by a better linker script.
3. Name the file as src/main_$(APP_NAME).c. Under msp430ratchet_full/, do
>> ./compile.sh ratchet wisp $(APP_NAME).

## Important Notes:
1. It is only tested with LLVM v3.8. High possibility that it might not be compatible with other versions (especially because of the crude python backend).
1-1. SIDENOTE: LLVM v3.8 for MSP430 is much slower than the MSPGCC or the TI compiler (LLVM v6 is not much better...). Comparing the performance against anything compiled with other than LLVM v3.8 will not be a fair comparison.
2. Only tested with optimization level -O0. 
3. The compiler pass only goes over the app code, instead of the entire libraries (the original paper instruments the entire libraries). This is safe as long as the functions from the libraries are idempotent, which was the case for all my code.
4. All of the backend optimizations proposed in the original paper is not implemented. It can give 1.6x speedup on average if implemented (according to the paper).
