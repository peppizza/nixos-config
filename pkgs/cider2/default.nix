{
  lib,
  requireFile,
  appimageTools,
}:

let
  pname = "cider";
  version = "2.4.1";

  src = requireFile {
    name = "Cider-${version}.AppImage";
    url = "https://cidercollective.itch.io/";
    sha256 = "a75347d75f90be4857acf9dfb28cec6e6ad8e19932550d70705a8b92657e47b7";
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
      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace-fail 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

}
