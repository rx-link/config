{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkIf;
  inherit (lib.kgrid) mkBoolOpt;

  cfg = config.kgrid.system.xkb;
in
{
  options.kgrid.system.xkb = {
    enable = mkBoolOpt false "Enable XKB";
  };

  config = mkIf cfg.enable {
    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
      # options = [ "caps:swapescape" ];
    };
  };
}
