
This project is an x86 Assembly program written for the 16-bit real mode using DOS interrupts (INT 21h).  
It presents a simple menu to the user with three options:

## 📋 Menu Options
1. **Prime Number Checker** – Accepts a number between 2 and 255, checks if it's prime, and:
   - If prime: prints a triangle of `@` symbols.
   - If not prime: prints a square of `*` symbols.

2. **Caesar's Shift Coder** – Encodes an English lowercase string using Caesar cipher (with a shift between 2–9).

3. **Exit** – Exits the program using interrupt 21h function 4Ch.

## 🧰 Files
- `yoni.asm` – Main source file containing the entire code and logic.
- `.gitignore` – Ignores build artifacts and OS-specific files.
- `README.md` – This file.

## ▶️ Usage
Assemble and run using any x86-compatible assembler and emulator (e.g., `TASM`, `MASM`, `DOSBox`, or `emu8086`).

### Example (TASM/MASM):
```bash
tasm yoni.asm
tlink yoni.obj
yoni.exe
```

## 🚀 Features
- User input via keyboard (INT 21h, AH=1 or 7).
- Formatted output (INT 21h, AH=9).
- Integer parsing from string input (up to 3 digits).
- Prime-checking logic with visual ASCII output.
- Basic Caesar cipher implementation with validation.
