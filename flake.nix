{
  description = "Sample Nix flake to build a Hello World C program";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

  outputs = { self, nixpkgs }: {
    packages.x86_64-linux.hello-flake = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.stdenv.mkDerivation {
      pname = "hello-flake";
      version = "1.0.0";

      src = ./.;

      buildInputs = [ pkgs.gcc ];

      buildPhase = ''
        gcc -o hello hello.c
      '';

      installPhase = ''
        mkdir -p $out/bin
        cp hello $out/bin/
      '';
    };
  };
}

