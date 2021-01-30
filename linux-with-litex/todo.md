# ToDo list

- [ ] Chargement d'un binaire cross-compilé.
- [ ] "Bidouilles" des périphériques existants.
- [x] Recompil d'un noyau Linux Buildroot si on veut ajouter 2-3 utilitaires

## Architecture de base

Attention, dans l'architecture de base disponible ici https://github.com/litex-hub/linux-on-litex-vexriscv, le CPU a été compilé avec l'ISA `rv32ima`.

Quelques informations sur les options du compilateur sont disponibles [ici](./compiler-options.md).

## Utilisation d'un binaire cross-compilé

### Compilation

Soit le code C suivant :

```c
#include <stdio.h>
int main()
{
    printf("Hello EVEEX !\n");
    return 0;
}
```

On le compile (ici avec la chaîne précompilée de SiFive) :

```bash
riscv64-unknown-elf-gcc -march=rv32ima -mabi=ilp32 -D__vexriscv__ -DUART_POLLING main.c -o main.elf
```

On le charge à partir de la carte SD une fois le Linux booté (voir https://github.com/litex-hub/linux-on-litex-vexriscv/blob/master/HOWTO.md)

### Téléchargement

#### Chargement du binaire à partir de la carte SD

TODO

#### Solutions plus élégantes

https://github.com/enjoy-digital/litex/wiki/Load-Application-Code-To-CPU

## Manipulations des périphériques existants

TODO

## Recompilation d'un noyau Linux avec Buildroot

```bash
$ git clone http://github.com/buildroot/buildroot
$ cd buildroot
$ make BR2_EXTERNAL=../linux-on-litex-vexriscv/buildroot/ litex_vexriscv_defconfig
$ make menuconfig # Si on veut ajouter des choses 
$ make -j$(nproc)
```

