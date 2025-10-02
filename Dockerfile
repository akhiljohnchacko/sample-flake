FROM nixpkgs/nix:nixos-25.05-x86_64-linux

# Enable flakes + nix-command globally
ENV NIX_CONFIG="experimental-features = nix-command flakes"

RUN nix-channel --add https://nixos.org/channels/nixos-25.05 nixpkgs \
 && nix-channel --update \
 && nix-env -iA \
      nixpkgs.jdk17_headless \
      nixpkgs.cacert \
      nixpkgs.git \
      nixpkgs.curl \
      nixpkgs.coreutils \
      nixpkgs.tini \
      nixpkgs.gnupg \
 && ln -sf /etc/ssl/certs/ca-bundle.crt /etc/ssl/certs/ca-certificates.crt

# Install extra tools you need
#RUN nix profile install nixpkgs#git \
#                        nixpkgs#curl \
#                        nixpkgs#gnupg \
#                        nixpkgs#tini \
#                        nixpkgs#bash \
#                        nixpkgs#coreutils
