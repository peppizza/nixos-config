{
  pkgs ? import <nixpkgs> { },
}:
{
  cider2 = pkgs.callPackage ./cider2 { };
  illuminanced = pkgs.callPackage ./illuminanced { };
}
