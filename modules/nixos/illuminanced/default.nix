{
  imports = [./illuminanced.nix];

  services.illuminanced = {
    enable = true;
    settings = builtins.fromTOML (builtins.readFile (./illuminanced.toml));
  };
}
