{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.kgrid) mkBoolOpt;

  cfg = config.kgrid.system.uefi;
in
{
  options.kgrid.system.uefi = {
    enable = mkBoolOpt false "Enable firmware updates";
  };

  config = mkIf cfg.enable {
    services.fwupd.enable = true;
  };
}
