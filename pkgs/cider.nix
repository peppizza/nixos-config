{ lib, appimageTools, fetchurl }:

appimageTools.wrapType2 rec {
  pname = "cider";
  version = "2.4.1";

  src = fetchurl {
    url = "file://${./Cider-${version}.AppImage}";
    sha256 = "a75347d75f90be4857acf9dfb28cec6e6ad8e19932550d70705a8b92657e47b7";
  };

  extraInstallCommands =
    let contents = appimageTools.extract { inherit pname version src; };
    in ''
      mv $out/bin/${pname}-${version} $out/bin/${pname}

      install -m 444 -D ${contents}/${pname}.desktop -t $out/share/applications
      substituteInPlace $out/share/applications/${pname}.desktop \
        --replace 'Exec=AppRun' 'Exec=${pname}'
      cp -r ${contents}/usr/share/icons $out/share
    '';

  meta = with lib; {
    description = "A new look into listening and enjoying Apple Music in style and performance.";
    homepage = "https://cider.sh/";
    maintainers = [ maintainers.peppizza ];
    platforms = [ "x86_64-linux" ];
  };
}
