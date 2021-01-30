# ToDo list

- [ ] Chargement d'un binaire cross-compilé.
- [ ] "Bidouilles" des périphériques existants.
- [ ] Recompil d'un noyau Linux Buildroot si on veut ajouter 2-3 utilitaires

## Architecture de base

Attention, dans l'architecture de base disponible ici https://github.com/litex-hub/linux-on-litex-vexriscv, le CPU a été compilé avec l'ISA `rv32ima`.

Quelques informations sur les options du compilateur sont disponibles [ici](./compiler_options.md).

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

On le compile :

```bash

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

TODO