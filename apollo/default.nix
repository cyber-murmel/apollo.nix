{ pkgs
, stdenv
, fetchFromGitHub
, gcc-arm-embedded
, ...
}:

with pkgs;

stdenv.mkDerivation {
  name = "apollo";
  src = fetchFromGitHub {
    owner = "greatscottgadgets";
    repo = "apollo";
    rev = "1207a45559c2c5fdfcd29ff18e2005a091c4412f";
    sha256 = "1qn14p3fcnx7vq0gqf0j9h2gjg10c3lvzc9lmcbbhfsaz5f1jp0q";
    fetchSubmodules = true;
  };
  APOLLO_BOARD = "luna";
  makeFlags = [ "-C" "firmware" ];
  buildInputs = [ gcc-arm-embedded ];
  installPhase = ''
    mkdir -p $out

    cp firmware/_build/*/*.{bin,elf,hex,elf.map} $out
  '';
  dontFixup = true;
}
