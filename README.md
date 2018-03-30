# COBOLd

Fix your COBOL programs automatically with the power of genetic programming. 

# Demo

- Install a COBOL compiler:

`sudo apt-get install open-cobol`

- Install [GenProg](https://github.com/squaresLab/genprog-code)

- Clone this repository:
```
git clone https://github.com/squaresLab/COBOLd.git
```

- Compile `limit.c` in the `src` directory, naming the binary `limit`
```
cd COBOLd/src
gcc -o limit limit.c
```

- Then `cd` to the bug you'd like to repair and run GenProg using the
configuration file included with the bug:
```
cd COBOLd/code/zunebug
/path/to/genprog-code/src/repair configuration
```

It may take a few runs (the search is stochastic, after all!), but if GenProg
finds a repair it will report `repair found`, and output the repaired version of
the program to a `repair` subdirectory.

# Cite us:

```
@article{squareslab2018cobol,
  title={COBOLd: Gobblin' Up COBOL Bugs for Fun and Profit},
  author={Timperley, Chris and Katz, Deby and Coker, Zack, and van Tonder, Rijnard and Soto, Mauricio and Afzal, Afsoon and Lacomis, Jeremy and Le Goues, Claire and Brady, Adam},
  journal={A Record of The Proceedings of SIGBOVIK 2018},
  pages={138--142},
  year={2018}
}
```
