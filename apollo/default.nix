{ pkgs
, stdenv
, fetchFromGitHub
, gcc-arm-embedded
, ...
}:

with pkgs;

stdenv.mkDerivation rec {
  name = "apollo";
  src = fetchgit {
    url = "https://github.com/greatscottgadgets/apollo.git";
    deepClone = true;
    rev = "1207a45559c2c5fdfcd29ff18e2005a091c4412f";
    sha256 = "1yvqvzaj24l6mhb67vx37zvrn3y9qnzr3wm1j7ll0h35nqfjdq58";
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
