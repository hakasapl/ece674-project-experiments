# ece674-project-experiments
Scripts relevant to ece674 class project @ UMass Amherst

## Required APT Packages
* `stress-ng`
* `powercap-utils`

## Setting Powercaps

`-l` Argument is in micro-watts. Change the first value of `-z` to set the other socket

### CPU ###

```
sudo powercap-set intel-rapl -z 0:0 -c 0 -l 130000000
```

### DRAM ###

```
sudo powercap-set intel-rapl -z 0:1 -c 0 -l 84000000
```
