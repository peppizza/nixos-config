{
  inputs,
  config,
  lib,
  ...
}:
{
  nix = {
    # Add flake inputs as a registry
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add inputs to legacy system channels
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    settings = {
      # Reasonable defaults
      connect-timeout = 5;
      log-lines = 25;
      min-free = 128000000;
      max-free = 1000000000;

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
    };
  };
}
