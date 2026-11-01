{
  description = "rust compiler";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "rust";
          packages = [
            pkgs.git
            (pkgs.python312.withPackages (ps: [
              ps.hatchling
              ps.beautifulsoup4
              ps.mobi
              ps.pdfquery
              ps.requests
              ps.six
              ps.tqdm
              ps.syrupy
              ps.pypdf
            ]))
            pkgs.pyright
            pkgs.ruff
          ];
        };
      }
    );
}
