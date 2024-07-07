{
  pkgs ? import <nixpkgs> { },
}:
rec {
  cider2 = pkgs.callPackage ./cider2 { };
  illuminanced = pkgs.callPackage ./illuminanced { };
}
