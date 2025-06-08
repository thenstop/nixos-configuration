{ config, lib, pkgs, ... }: {
  # Install cloudflared
  environment.systemPackages = [ pkgs.cloudflared ];

  # Setup cloudflared service
  systemd.services.cloudflared = {
    wantedBy = [ "multi-user.target" ];
    after = [ "network.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared proxy-dns --upstream https://dns.nextdns.io";
      Restart = "always";
      User = "root";
      Group = "root";
    };
  };
}
