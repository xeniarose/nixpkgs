{
  lib,
  stdenv,
  fetchFromGitHub,
  tt-rss,
}:

stdenv.mkDerivation rec {
  pname = "tt-rss-plugin-feediron";
  version = "1.33";

  src = fetchFromGitHub {
    owner = "feediron";
    repo = "ttrss_plugin-feediron";
    rev = "v${version}";
    sha256 = "sha256-KU4XQJNK7Ua7rZaXA32lv16RlloCysAb54E5kEY847A=";
  };

  installPhase = ''
    mkdir -p $out/feediron

    cp -r bin filters init.php preftab recipes $out/feediron/
  '';

  meta = with lib; {
    description = "Evolution of ttrss_plugin-af_feedmod";
    longDescription = ''
      This is a plugin for Tiny Tiny RSS (tt-rss).
      It allows you to replace an article's contents by the contents of an element on the linked URL's page

      i.e. create a "full feed".
    '';
    license = licenses.mit;
    homepage = "https://github.com/feediron/ttrss_plugin-feediron";
    maintainers = with maintainers; [ milogert ];
    inherit (tt-rss.meta) platforms;
  };
}
