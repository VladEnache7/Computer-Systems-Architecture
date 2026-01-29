
# 💻 Computer Systems Architecture (CSA)

This course dives deep into the hardware-software interface, covering the 80x86 microprocessor architecture, low-level memory management, and Assembly language (NASM) programming.

### 📅 Weekly Syllabus

| Week | 👨‍🏫 Course Content | 📝 Seminar (Bi-Weekly) | ⌨️ Laboratory (Assembly) |
|:---:|:---|:---|:---|
| **1** | **Data Representation:** Elementary data, binary representation, storage | **S1: Intro to IA-32:** Base conversions, Memory representation | **L1: Base Conversions:** Bit, Sign bit, Complementary code, Lab tools |
| **2** | **Character Coding:** Signed/unsigned, Complementary code, Overflow | *--* | **L2: Simple Arithmetic:** Additions, subtractions, multiplications, divisions |
| **3** | **Architecture:** CPU, System clock, n-bit computers, Peripherals | **S2: Arithmetic:** Signed/unsigned instructions, Mul/Div | **L3: Complex Arithmetic:** Little-endian, Variable declaration |
| **4** | **80x86 Architecture:** Addressing modes, Near vs. Far addresses | *--* | **L4: Bitwise Instructions:** Logical ops, Shift, Rotate |
| **5** | **Executive Unit (EU):** Registers (General, Flags), Functions | **S3: Flow Control:** Little-endian, Jumps, String intro | **L5: Simple Strings:** Comparisons, Loops, Conditional jumps |
| **6** | **Bus Interface Unit (BIU):** Segment registers, Offset specification (16 vs 32 bit) | *--* | **L6: Complex Strings:** `LODSB`, `STOSB`, `SCASB` instructions |
| **7** | **Assembly Basics:** Source format, Operands, Operators | **S4: Strings (Advanced):** Complex string problems | **L7: Function Calls:** External libs, `msvcrt`, Call conventions |
| **8** | **Directives:** Segments (`DATA`, `CODE`), `EQU`, `INCLUDE`, Macros | *--* | ❗ **MIDTERM TEST (Moodle)** |
| **9** | **Instructions I:** Transfer, Arithmetic, Bitwise shifting/rotating | **S5: Library Calls:** `printf`, `scanf`, file ops | **L9: File Operations:** Text files (open, read, write, close) |
| **10** | **Instructions II:** Jumps, Loops, String instructions, Overflow analysis | *--* | **L10: Review:** Catch-up on homework, Evaluation |
| **11** | **Subprograms:** `CDECL` vs `STDCALL`, Entry/Exit code, `EXTRN`/`GLOBAL` | **S6: Multi-module:** Programming with ASM + ASM | **L11: Multi-module I:** Assembly + Assembly linking |
| **12** | **Linking Modules:** NASM with C, Recursive calls | *--* | **L12: Multi-module II:** Assembly + C linking |
| **13** | **Libraries:** Static (LIB) vs Dynamic (DLL), Win32 system libraries | **S7: Review:** Case studies & Exam prep | **L13: Exam Prep:** Review & Case studies |
| **14** | **Protected Mode:** Real vs. Protected mode, Virtual memory, Paging | *--* | 🏁 **PRACTICAL EXAM** |

---

### 📚 Key Topics Breakdown

<details>
<summary><strong>Click to expand detailed topic list</strong></summary>

#### Part I: Data & Architecture
*   **Representation:** Binary, Hexadecimal, Two's Complement (Signed Integers).
*   **Hardware:** CPU internal structure (EU, BIU), Registers (`EAX`, `EBX`, `ECX`, `EDX`, `ESI`, `EDI`, `EBP`, `ESP`).
*   **Memory:** Little Endian vs. Big Endian, Segmentation, Paging.

#### Part II: Assembly Language (NASM)
*   **Arithmetic:** `ADD`, `SUB`, `MUL`, `IMUL`, `DIV`, `IDIV`.
*   **Logic:** `AND`, `OR`, `XOR`, `NOT`, `TEST`.
*   **Control Flow:** `JMP`, `JE`, `JNE`, `JG`, `JL` (Conditional Jumps), `LOOP`.
*   **Strings:** `MOVSB`, `LODSB`, `STOSB`, `SCASB`, `CMPSB` along with `REP` prefixes.

#### Part III: Advanced Programming
*   **The Stack:** `PUSH`, `POP`, Stack Frames.
*   **Function Calls:** Calling conventions (`CDECL`, `STDCALL`), preserving registers.
*   **Interfacing:** Calling C functions from Assembly, and Assembly functions from C.
*   **System:** Real Mode vs. Protected Mode, Interrupts.

</details>

---

### 🛠️ Resources & Tools

*   **NASM (Netwide Assembler)** - The assembler used for the labs.
*   **OllyDbg / x32dbg** - Debuggers for analyzing binary execution and registers.
*   **Visual Studio** - For multi-module programming (C + ASM).

---

> *"There are 10 types of people in the world: those who understand binary, and those who don't."*
