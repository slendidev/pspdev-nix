# pspdev-nix

Nix flake that provides a PSP development toolchain.

## Usage

In a `flake.nix` add the following:

```nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pspdev = {
      url = "github:slendidev/pspdev-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = nixpkgs.lib.systems.flakeExposed;

      perSystem = { system, ... }: {
        devShells.default = inputs.pspdev.devShells.${system}.default;
      };
    };
}
```

You should then be able to run `nix develop`, or if you have
[nix-direnv](https://github.com/nix-community/nix-direnv) installed, add to
.envrc:

```
use flake
```

And you should be good to go!

