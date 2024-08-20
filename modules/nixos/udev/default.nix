{ lib, pkgs, ... }:
{
  services.udev.packages = lib.singleton (
    pkgs.writeTextFile {
      name = "probe-rs-rules";
      text = builtins.readFile (./69-probe-rs.rules);
      destination = "/etc/udev/rules.d/69-probe-rs.rules";
    }
  );
}
