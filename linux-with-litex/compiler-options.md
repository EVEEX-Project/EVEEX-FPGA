# Options du compilateur

> Reprise de https://five-embeddev.com/toolchain/2019/06/26/gcc-targets/

Getting started with RISC-V. Compiling for the RISC-V target. This post covers the GCC machine architecture (*-march*), ABI (*-mabi*) options and how they relate to the RISC-V base ISA and extensions. It also looks at the multilib configuration for GCC.

Selecting

- the [base ISA](https://five-embeddev.com/riscv-isa-manual/latest/intro.html#risc-v-isa-overview),
- the [extensions](https://five-embeddev.com/riscv-isa-manual/latest/naming.html#naming), and
- the target [ABIs](https://five-embeddev.com/riscv-isa-manual/latest/assembly.html).

#### Machine Architecture and ABI

When compiling for RISC-V figuring out the compiler target correct is one of the first complications of having an extendable architecture. [GCC has the following options](https://gcc.gnu.org/onlinedocs/gcc-8.3.0/gcc/RISC-V-Options.html#RISC-V-Options):

- The *-march=* option selects the base ISA + extensions. The extensions should be specified in a [canonical order](https://five-embeddev.com/riscv-isa-manual/latest/naming.html#isanametable) that the compiler can recognize. Only the extensions relevant to the compiler are needed.
- The *-mabi=* option selects the calling convention ABI.
  - e.g. **ilp32e** for the **rv32e** eabi
  - e.g. **ilp32**, for the **rv32i** without floating point hardware, or **ilp32{f,d}** with single or double precision registers.
  - e.g. **ilp64**, for the **rv64i** without floating point hardware, or **ilp64{f,d}** with single or double precision registers.

The architecture string has a canonical order and format:

- The base ISA is first. (e.g. rv32e, rv32i, rv64i)    
  - Aliases can be used. (e.g. **rv32g**=**rv32imafd**)
- Must be lower case.
- Must be in the canonical order.    
  - To match the library path, order is important.
- For the current GCC (8.2.0) single letter extension names may *NOT* be separated by underscore.

There is also a relation between the *-march=* and *-mabi=*:

- Not specifying *-mabi=* seems to select a default value “.”, not a specific ABI.
- Only some combinations of base ISA and supported extensions/ABIs.    
  - e.g. the **ipl32e** ABI can’t be used with **rv32i** or **rv64i**.
- These may fail at link time rather than be detected.

The GCC source for the options parser is here: [riscv-gcc-8.2.0/gcc/common/config/riscv/riscv-common.c](https://github.com/riscv/riscv-gcc/blob/riscv-gcc-8.2.0/gcc/common/config/riscv/riscv-common.c)

#### Code Generation

The RISC-V GCC compiler can generate code for all (supported) extensions and ABIs, a separate compiler binary is not needed for each base ISA. Depending on how the compiler was configured at build time the name may be riscv-none-embed-gcc, or riscv32-unknown-elf-gcc or riscv64-unknown-elf-gcc, however they can all compile for any base ISA and extensions and address size.

The following *-march=* options are recognized by the gcc compiler (as of 8.2.0) and configured at run time:

Base ISAs recognized:

- **rv32** : 32 bit ISA.
- **rv64** : 64 bit ISA.
- **e** : rv32e embedded ISA, only 16 general purpose registers.
- **i** : base integer ISA.

Extensions recognized:

- **g** : alias for **imafd**.
- **m** : multiplication and division instructions.
- **a** : atomic instructions.
- **f** : floating point instructions.
- **d** : double float.
- **c** : compressed instructions.

#### Link Libraries

Unlike the code generation, the default target (when no *-march=* option is given) and the architecture and ABIs with supported libraries  will depend on the build time configuration. The compiler’s build  configuration selects:

- The combination(s) of *-march=* and *-mabi=* used to compile the compiler’s link libraries (libgcc, libc etc).

- The compiler may have been built with a 

  single

   library to support just one machine architecture.    

  - This will only work if you compile for the same or compatible architecture.

- The compiler may have been built with 

  multiple

   libraries for several architectures (multilib).    

  - The GCC configure build scripts do not support all targets for  multilib.

The option *–print-multi-lib* will indicate the supported targets. For example:

- Single library: A GCC with a custom configuration, built from source (from [github](https://github.com/riscv/riscv-gnu-toolchain) ) supporting only one target library.
  - I’m not sure the correct way to check the libgcc architecture in this case.        
    - GCC can give the path of libgcc, inspecting the debug contents reveals the compile options.

```bash
$ riscv32-unknown-elf-gcc --print-multi-lib
.;

$ riscv32-unknown-elf-gcc --print-multi-directory
.
$ riscv32-unknown-elf-gcc -print-libgcc-file-name
...gcc_riscv32_unknown_elf-8.2.0/bin/../lib/gcc/riscv32-unknown-elf/8.2.0/libgcc.a

$ riscv32-unknown-elf-objdump --debugging ...gcc_riscv32_unknown_elf-8.2.0/bin/../lib/gcc/riscv32-unknown-elf/8.2.0/libgcc.a | grep -m 1 DW_AT_producer
    <c>   DW_AT_producer    : (indirect string, offset: 0x5b4): GNU C17 8.2.0 -mcmodel=medlow -mcmodel=medlow -march=rv32ec -mabi=ilp32e -g -Os -O2 -Os -fbuilding-libgcc -fno-stack-protector -fvisibility=hidden
```

- Multlib: For the GCC from 8.2.0-2.2-20190521-0004 build of GCC from the [GNU MCU Eclipse project](https://gnu-mcu-eclipse.github.io/).

```bash
$ riscv-none-embed-gcc --print-multi-lib
.;
rv32e/ilp32e;@march=rv32e@mabi=ilp32e
rv32em/ilp32e;@march=rv32em@mabi=ilp32e
rv32eac/ilp32e;@march=rv32eac@mabi=ilp32e
rv32emac/ilp32e;@march=rv32emac@mabi=ilp32e
rv32i/ilp32;@march=rv32i@mabi=ilp32
rv32im/ilp32;@march=rv32im@mabi=ilp32
rv32iac/ilp32;@march=rv32iac@mabi=ilp32
rv32imac/ilp32;@march=rv32imac@mabi=ilp32
rv32imaf/ilp32f;@march=rv32imaf@mabi=ilp32f
rv32imafc/ilp32f;@march=rv32imafc@mabi=ilp32f
rv32imafdc/ilp32d;@march=rv32imafdc@mabi=ilp32d
rv64imac/lp64;@march=rv64imac@mabi=lp64
rv64imafc/lp64f;@march=rv64imafc@mabi=lp64f
rv64imafdc/lp64d;@march=rv64imafdc@mabi=lp64d

$ riscv-none-embed-gcc --print-multi-directory
rv32imac/ilp32
```

If you are compiling for other architectures not listed by *–print-multi-lib* a compatible library may be selected. This may not be optimal.

- e.g. When using riscv-none-embed-gcc for -march=**rv32ec**, the **rv32e** library is selected. This will not include compressed instructions so will be larger than necessary.

```bash
$ riscv-none-embed-gcc -march=rv32ec -mabi=ilp32e --print-multi-directory
rv32e/ilp32e
```

#### Notes

An example of compiling for different targets is [here](https://github.com/five-embeddev/riscv-scratchpad/tree/master/targets).

The compiler needs to be able to translate the *-march=* and *-mabi=* options into a fixed path. For 8.2.0-2.2-20190521-0004 directories are:

```bash
lib/gcc/riscv-none-embed/8.2.0/
     rv32e/ilp32e
     rv32eac/ilp32e
     rv32em/ilp32e
     rv32emac/ilp32e
     rv32i/ilp32
     rv32iac/ilp32
     rv32im/ilp32
     rv32imac/ilp32
     rv32imaf/ilp32f
     rv32imafc/ilp32f
     rv32imafdc/ilp32d
     rv64imac/lp64
     rv64imafc/lp64f
     rv64imafdc/lp64d
```

These are the C runtime and compiler support files that are compiled for each architecture:

```bash
lib/gcc/riscv-none-embed/8.2.0/<march>/<mabi>
     crtbegin.o
     crtend.o
     crti.o
     crtn.o
     libgcc.a
     libgcov.a
riscv-none-embed/lib/<march>/<mabi>
     libc.a
     libc_nano.a
     libg.a
     libgloss.a
     libg_nano.a
     libm.a
     libnosys.a
     libsim.a
     libstdc++.a
     libstdc++_nano.a
     libsupc++.a
     libsupc++_nano.a    
```