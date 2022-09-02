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
rec{
  apollo = callPackage ./apollo { inherit pkgs; };
  apollo-qtpy = apollo.overrideAttrs (oldAttrs: {
    APOLLO_BOARD = "qtpy";
    src = fetchgit {
      url = "https://github.com/mkj/apollo.git";
      deepClone = true;
      rev = "e7adeb93bcf2c67cb623e8bb278e68416c39fceb";
      sha256 = "14hp7ll8ks9m3srgf9ajkr7pmmzfr4isp2fc6135slmkshs5q7kn";
    };
  });
}
