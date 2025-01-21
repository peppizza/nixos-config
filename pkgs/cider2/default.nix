{
  lib,
  requireFile,
  appimageTools,
}:

let
  pname = "cider";
  version = "2.6.0";

  src = requireFile {
    name = "Cider-${version}.AppImage";
    url = "https://cidercollective.itch.io/";
    sha256 = "sha256-BbS6bpODJyQu01N22j4tiZ8qMdnNMwGLltbFFok5fqE=";
  };

  meta = with lib; {
    description = "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cider.sh/";
    maintainers = [ maintainers.peppizza ];
    platforms = [ "x86_64-linux" ];
  };
in
appimageTools.wrapType2 {
  inherit
    pname
    version
    src
    meta
    ;

  extraInstallCommands =
    let
      contents = appimageTools.extract { inherit pname version src; };
    in
    ''
      install -m 444 -D ${contents}/Cider.desktop -t $out/share/applications
      cp -r ${contents}/usr/share/icons $out/share
    '';

}
