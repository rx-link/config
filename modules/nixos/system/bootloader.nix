{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.kgrid) mkBoolOpt;

  cfg = config.kgrid.system.bootloader;
in
{
  options.kgrid.system.bootloader = {
    enable = mkBoolOpt false "Enable bootloader";
  };

  config = mkIf cfg.enable {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
  };
}
