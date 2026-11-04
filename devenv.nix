{ pkgs, ... }:

{
  packages = [
    pkgs.git
  ];

  languages.nix.enable = true;
}
