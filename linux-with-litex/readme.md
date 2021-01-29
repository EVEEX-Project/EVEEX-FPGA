# linux-with-litex

## Manipulation de base

Voir : https://github.com/litex-hub/linux-on-litex-vexriscv

Fichiers à décompresser dans le dossier `images` :

- Noyau Linux : https://github.com/litex-hub/linux-on-litex-vexriscv/files/5753330/linux_2020_12_30.zip
- OpenSBI : https://github.com/litex-hub/linux-on-litex-vexriscv/files/5702162/opensbi_2020_12_15.zip

Commandes de base :

```bash
$ ./make.py --board=nexys4ddr --cpu-count=1 --build
$ ./make.py --board=nexys4ddr --cpu-count=1 --load
```

