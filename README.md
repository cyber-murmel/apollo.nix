# apollo.nix
A convenient environment for building and flashing apollo on NixOS

## Building
To build apollo, simply run `nix-build -A $package` in the root of this repository.
The available packages are listed in the set in [default.nix](default.nix).

```shell
# build default variant
nix-build -A apollo

# build QT Py variant
nix-build -A apollo-qtpy
```

## Flashing
For flashing run `nix-shell` in the root of this repository.
This enters an environment providing scripts for flashing apollo using [Black Magic Probe](https://github.com/blackmagic-debug/blackmagic) or [Device Firmware Upgrade](https://en.wikipedia.org/wiki/USB#Device_Firmware_Upgrade_mechanism).
It is not necessary to create the firmware manually, as it gets built when entering the environment.

```shell
# enter environment
nix-shell
```

### Black Magic Probe
If the micro controller has no bootlaoder installed, you can flash the firmware via SWD using a Black Magic Probe.

```shell
# flash apollo with Black Magic Probe
bmp-flash-apollo

# flash QT Py variant
bmp-flash-apollo-qtpy
```

### Device Firmware Upgrade
If the micro controller has a DFU bootloader installed (e.g. [saturn-v](https://github.com/greatscottgadgets/saturn-v)), you can upload the firmware directly via USB.

```shell
# flash apollo via Device Firmware Upgrade
dfu-flash-apollo

# flash QT Py variant
dfu-flash-apollo-qtpy
```
