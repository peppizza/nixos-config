{
  config,
  pkgs,
  lib,
  ...
}:

let
  cfg = config.services.illuminanced;

  toml = pkgs.formats.toml { };

  configFile = toml.generate "illuminanced.toml" cfg.settings;
in
{
  options.services.illuminanced = {
    enable = lib.mkEnableOption "Enable illuminanced, a daemon for controlling screen brightness using an ambient light sensor";

    settings = lib.mkOption {
      default = { };
      type = toml.type;
      example = {
        illuminance_file = "/sys/bus/iio/devices/iio:device0/in_illuminance_raw";
      };
      description = ''
        Configuration file for illuminanced. For documentation, see
        <https://github.com/peppizza/illuminanced/blob/master/README.md>
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = cfg.settings != {};
        message = "The .settings attribute must be set";
      }
    ];

    systemd.services.illuminanced = {
      description = "Ambient light monitoring Service";
      documentation = [ "https://github.com/peppizza/illuminanced" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "forking";
        ExecStart = "${pkgs.illuminanced}/bin/illuminanced -c ${configFile}";
        PIDFile = "/run/illuminanced.pid";
        Restart = "on-failure";
      };
    };
  };
}
