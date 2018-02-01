{ stdenv, fetchgit, sass, glib, libxml2, gdk_pixbuf, gtk-engine-murrine, inkscape, python3, optipng }:

stdenv.mkDerivation rec {
  version = "2018-02-02";
  name = "numix-gtk-theme-${version}";

  src = fetchgit {
    url = "https://github.com/Ferdi265/numix-solarized-gtk-theme.git";
    rev = "a353a1f0b182f29dbb00d235078eea717367669e";
    sha256 = "0n9nrr6h1q0nk4w8m4463mwir59jznhr9kkzj29c375pxmwfnncw";
  };

  nativeBuildInputs = [ inkscape sass glib libxml2 gdk_pixbuf python3 optipng ];

  buildInputs = [ gtk-engine-murrine ];

  postPatch = ''
    substituteInPlace Makefile --replace '$(INSTALL_DIR)' $out
    substituteInPlace Makefile --replace '$(THEME)' SolarizedDarkGreen
    substituteInPlace scripts/render-assets.sh --replace '/usr/bin/inkscape' 'inkscape'
    substituteInPlace scripts/render-assets.sh --replace '/usr/bin/optipng' 'optipng'
    patchShebangs .
  '';
}
