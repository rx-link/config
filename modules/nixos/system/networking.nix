{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:
let
  inherit (lib) types mkIf;
  inherit (lib.kgrid) mkBoolOpt mkOpt;

  cfg = config.kgrid.system.networking;
in
{
  options.kgrid.system.networking = with types; {
    enable = mkBoolOpt false "Enable networking";
    customDns = mkBoolOpt false "Enable custom DNS";

    hosts = mkOpt attrs { } "An attribute set to merge with <option>networking.hosts</option>";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      mtr
      tcpdump
      traceroute
    ];

    networking = {
      hostName = hostname;

      hosts = {
        "127.0.0.1" = [ "localhost" ];
      } // cfg.hosts;

      # Cloudflare DNS
      nameservers = mkIf cfg.customDns [
        "1.1.1.1"
        "1.0.0.1"
        "2606:4700:4700::1111"
        "2606:4700:4700::1001"
      ];
    };
  };
}
