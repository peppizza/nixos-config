{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "illuminanced";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "peppizza";
    repo = pname;
    rev = version;
    hash = "sha256-SohqLqAB0IVcHwurtbnVKi46YqU4/OuHK/CfWQgTHQM=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
  };

  postPatch = ''
    ln -sf ${./Cargo.toml} Cargo.toml
    ln -sf ${./Cargo.lock} Cargo.lock
  '';

  meta = with lib; {
    description = "A user mode daemon for automatically changing brightness based on light sensor value designed for modern laptops.";
    homepage = "https://github.com/peppizza/illuminanced";
    maintainers = with maintainers; [
      mikhail-m1
      peppizza
    ];
    platforms = [ "x86_64-linux" ];
  };

  installPhase = ''
    install -Dm744 target/x86_64-unknown-linux-gnu/release/illuminanced -t $out/bin/
  '';
}
