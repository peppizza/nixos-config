{
  lib,
  fetchFromGitHub,
  rustPlatform,
}:

rustPlatform.buildRustPackage rec {
  pname = "illuminanced";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "peppizza";
    repo = "illuminanced";
    rev = "c5af3114b1d6241099b9424d41432372ef232d2e";
    hash = "sha256-N6584PCIZ2rzVH2rAVv/WYPtUKbLEFhwVH3hbvcSSKo=";
  };

  cargoHash = "sha256-wgNISV2jfZZDaOr3p+knd8qBAafckSOwjWmLOpaBiWQ=";

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
