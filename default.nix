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
    src = fetchFromGitHub {
      owner = "greatscottgadgets";
      repo = "apollo";
      rev = "e7adeb93bcf2c67cb623e8bb278e68416c39fceb";
      sha256 = "09b1dn3sav5j68ad198hkd4cxzxch5ll7w149vgdd7wlj6qkj59f";
      fetchSubmodules = true;
    };
  });
}
