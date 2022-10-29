{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      devShells.default = pkgs.mkShell {
        name = "python";
        venvDir = "./venv";
        packages = with pkgs; [
          python39
          python39Packages.venvShellHook
        ];
        postVenvCreation = ''
          pip install --upgrade pip
          pip install -r requirements.txt
          source ./venv/bin/activate
        '';
      };

    });
}

