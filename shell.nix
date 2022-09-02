{ pkgs ? import
    (builtins.fetchGit {
      name = "nixos-22.05-2022_08_27";
      url = "https://github.com/nixos/nixpkgs/";
      ref = "refs/heads/nixos-22.05";
      rev = "f11e12ac6af528c1ba12426ce83cee26f21ceafd";
    })
    { }
}:

with pkgs;
let
  default = import ./. { inherit pkgs; };

  apollo = default.apollo;
  apollo-qtpy = default.apollo-qtpy;

  bmp-flash = name: elf: writeScriptBin name ''
    #! ${bash}/bin/bash

    set -euo pipefail

    BMP_SERIAL=''${1:-/dev/ttyACM0}

    ${gcc-arm-embedded}/bin/arm-none-eabi-gdb -nx --batch \
      -ex "target extended-remote $BMP_SERIAL" \
      -ex 'monitor swdp_scan' \
      -ex 'attach 1' \
      -ex 'monitor unlock_flash' \
      -ex 'monitor unlock_bootprot' \
      -ex 'monitor erase_mass' \
      -ex 'load' \
      -ex 'compare-sections' \
      -ex 'kill' \
      ${elf}
  '';

  dfu-flash = name: bin: writeScriptBin name ''
    #! ${bash}/bin/bash

    set -euo pipefail

    ${dfu-util}/bin/dfu-util -a 0 -d 1d50:615c -D ${bin} || dfu-util -a 0 -d 16d0:05a5 -D ${bin}
  '';

  bmp-flash-apollo = bmp-flash "bmp-flash-apollo" "${apollo}/*.elf";
  bmp-flash-apollo-qtpy = bmp-flash "bmp-flash-apollo-qtpy" "${apollo-qtpy}/*.elf";

  dfu-flash-apollo = dfu-flash "dfu-flash-apollo" "${apollo}/*.bin";
  dfu-flash-apollo-qtpy = dfu-flash "dfu-flash-apollo-qtpy" "${apollo-qtpy}/*.bin";
in
mkShell {
  buildInputs = [
    bmp-flash-apollo
    bmp-flash-apollo-qtpy

    dfu-flash-apollo
    dfu-flash-apollo-qtpy
  ];
  APOLLO = apollo;
  APOLLO_QTPY = apollo-qtpy;
}
