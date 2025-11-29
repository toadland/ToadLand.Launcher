{pkgs ? import <nixpkgs> {}}: let
  libs = with pkgs; [
    # SkiaSharp dependencies
    fontconfig
    freetype
    expat
    libpng
    libjpeg
    zlib
    # X11 dependencies for Avalonia
    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libICE
    xorg.libSM
  ];
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      dotnet-sdk_8
      git

      gnumake

      # SkiaSharp dependencies
      fontconfig
      freetype
      expat
      libpng
      libjpeg
      zlib
      # X11 dependencies for Avalonia
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libICE
      xorg.libSM

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
