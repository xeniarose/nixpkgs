{
  lib,
  stdenv,
  fetchurl,
  zlib,
}:

stdenv.mkDerivation rec {
  pname = "subread";
  version = "2.1.0";

  src = fetchurl {
    url = "mirror://sourceforge/subread/subread-${version}/subread-${version}-source.tar.gz";
    sha256 = "sha256-/fioTPFF7atJhAcOcVlWEsl603Qa/bjSX5Pa58hwNDM=";
  };

  buildInputs = [
    zlib
  ];

  configurePhase = ''
    cd src
    cp Makefile.${if stdenv.hostPlatform.isLinux then "Linux" else "MacOS"} Makefile
  '';

  makeFlags = [ "CC_EXEC=cc" ];

  installPhase = ''
    mkdir $out
    cp -r ../bin $out
  '';

  meta = with lib; {
    broken = stdenv.hostPlatform.isDarwin;
    description = "High-performance read alignment, quantification and mutation discovery";
    license = licenses.gpl3;
    maintainers = with maintainers; [ jbedo ];
    platforms = [
      "x86_64-darwin"
      "x86_64-linux"
    ];
    homepage = "https://subread.sourceforge.net/";
  };

}
