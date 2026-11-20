{
  description = "UptimeFlare upstream source (lyc8503/UptimeFlare), pinned to default-branch HEAD.";

  inputs = {
    flake-lib.url = "github:jgus-org/flake-lib/v1";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      flake-lib,
      nixpkgs,
    }:
    flake-lib.lib.eachDefaultSystem (
      system:
      let
        pin = import ./pin.nix;
        pkgs = import nixpkgs { inherit system; };
        orgFormatting = flake-lib.lib.mkFormatting {
          inherit self system;
        };
      in
      {
        checks.formatting = orgFormatting.check;
        formatter = orgFormatting.formatter;
        packages = rec {
          default = src;
          src =
            pkgs.lib.meta.addMetaAttrs
              {
                license = pkgs.lib.licenses.asl20;
              }
              (
                pkgs.fetchFromGitHub {
                  hash = pin.sourceHash;
                  owner = "lyc8503";
                  repo = "UptimeFlare";
                  rev = pin.sourceRev;
                }
              );
          update-version = flake-lib.lib.mkUpdateVersion {
            inherit pkgs;
            source = {
              owner = "lyc8503";
              repo = "UptimeFlare";
              track = "commit";
              type = "github";
            };
          };
        };
      }
    );
}
