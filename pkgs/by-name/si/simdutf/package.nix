{ lib
, stdenv
, fetchFromGitHub
, cmake
, libiconv
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "simdutf";
  version = "5.2.3";

  src = fetchFromGitHub {
    owner = "simdutf";
    repo = "simdutf";
    rev = "v${finalAttrs.version}";
    hash = "sha256-aGuztJLHfC/GZuvZSieWOOYN5VyvxYCZKGX1nQQDvxo=";
  };

  # Fix build on darwin
  postPatch = ''
    substituteInPlace tools/CMakeLists.txt --replace "-Wl,--gc-sections" ""
  '';

  nativeBuildInputs = [
    cmake
  ];

  buildInputs = [
    libiconv
  ];

  meta = with lib; {
    description = "Unicode routines validation and transcoding at billions of characters per second";
    homepage = "https://github.com/simdutf/simdutf";
    license = with licenses; [ asl20 mit ];
    maintainers = with maintainers; [ rewine ];
    mainProgram = "simdutf";
    platforms = platforms.all;
  };
})
