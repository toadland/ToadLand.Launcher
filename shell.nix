{pkgs ? import <nixpkgs> {}}: let
  libs = with pkgs; [
    # C++ standard library
    # Note: If you need a specific GCC version, use: gccNGPackages_15.libstdcxx.out
    # For standard nixpkgs, gcc.cc.lib should work
    gcc.cc.lib
    # Core system libraries
    libz.out
    icu
    fontconfig
    # OpenGL
    libGL
    # X11 dependencies for Avalonia
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXi
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXfixes
    xorg.libICE
    xorg.libSM
    xorg.libXinerama
    xorg.libXtst
    xorg.libXt
    xorg.libXaw
    xorg.libXmu
    xorg.libXpm
    # SkiaSharp dependencies
    freetype
    expat
    libpng
    libjpeg
    # SSL/TLS
    openssl
    # Text-to-speech (flite)
    flite
    # GUI utilities
    zenity
  ];
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      dotnet-sdk_8
      git
      gnumake

      # C++ standard library
      # Note: If you need a specific GCC version, use: gccNGPackages_15.libstdcxx.out
      # For standard nixpkgs, gcc.cc.lib should work
      gcc.cc.lib
      # Core system libraries
      libz.out
      icu
      fontconfig
      # OpenGL
      libGL
      # X11 dependencies for Avalonia
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libXi
      xorg.libXrandr
      xorg.libXcursor
      xorg.libXfixes
      xorg.libICE
      xorg.libSM
      xorg.libXinerama
      xorg.libXtst
      xorg.libXt
      xorg.libXaw
      xorg.libXmu
      xorg.libXpm
      # SkiaSharp dependencies
      freetype
      expat
      libpng
      libjpeg
      zlib
      # SSL/TLS
      openssl
      # Text-to-speech (flite)
      flite
      # GUI utilities
      zenity

      # AppImage tooling helpers
      file
      appstream
      gnupg

      curl
      wget
    ];

    shellHook = ''
      echo "Gml.Launcher development environment"
      echo "===================================="
      echo ".NET SDK version:"
      dotnet --version
      echo ""
      echo "Git version:"
      git --version
      echo ""
      echo "To initialize submodules, run:"
      echo "  git submodule update --init --recursive"
      echo ""
      echo "To build the project:"
      echo "  dotnet restore"
      echo "  dotnet build"
      echo ""
      echo "To run the project:"
      echo "  dotnet run --project src/Gml.Launcher/Gml.Launcher.csproj"

      # Set up library path for SkiaSharp and Avalonia dependencies
      export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"
    '';
  }
