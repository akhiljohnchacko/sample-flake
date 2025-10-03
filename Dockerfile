# syntax=docker/dockerfile:1.6
FROM nixpkgs/nix:nixos-25.05-x86_64-linux

ENV NIX_CONFIG="experimental-features = nix-command flakes"
ENV NIXPKGS_PIN="nixpkgs/nixos-25.05"
ENV NIX_PATH="nixpkgs=channel:nixos-25.05"

# Install required tools + Java (for Jenkins agent injection)
RUN nix profile install \
      "${NIXPKGS_PIN}#jdk17_headless" \
      "${NIXPKGS_PIN}#cacert" \
      "${NIXPKGS_PIN}#curl" \
      "${NIXPKGS_PIN}#coreutils" \
      "${NIXPKGS_PIN}#gnupg" \
      "${NIXPKGS_PIN}#openssh" \
      "${NIXPKGS_PIN}#shadow" \
      "${NIXPKGS_PIN}#tini" \
      "${NIXPKGS_PIN}#bash"

# export PATH
ENV PATH="/root/.nix-profile/bin:${PATH}"

# Tini as init
ENTRYPOINT ["tini", "--"]

# Keep container alive until Jenkins agent.jar is injected
CMD ["cat"]
