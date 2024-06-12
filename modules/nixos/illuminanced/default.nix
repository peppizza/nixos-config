{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    illuminanced
  ];

  systemd.services.illuminanced = {
    description = "Ambient light monitoring Service";
    documentation = [ "https://github.com/mikhail-m1/illuminanced" ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${pkgs.illuminanced}/bin/illuminanced -c /etc/illuminanced.toml";
      PIDFile = "/run/illuminanced.pid";
      Restart = "on-failure";
    };
    wantedBy = [ "multi-user.target" ];
  };

  environment.etc."illuminanced.toml".source = ./illuminanced.toml;
}
