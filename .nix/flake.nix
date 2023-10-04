{
  description = "A basic flake with a shell";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        RUST_VERSION = "1.70.0";
      in
      {
        devShell = pkgs.mkShell {
          nativeBuildInputs = [ pkgs.bashInteractive ];
          buildInputs = with pkgs; [
            rustup
            sccache
            trunk
            dart-sass
            nodePackages.vscode-html-languageserver-bin
          ];

          RUSTC_WRAPPER = "${pkgs.sccache}/bin/sccache";

          shellHook = ''                                                                                                                                   
            pre-commit install --allow-missing-config --hook-type pre-commit --hook-type commit-msg                                                        

            rustup default ${RUST_VERSION}                                                                                                                 
            rustup target add --toolchain ${RUST_VERSION} wasm32-unknown-unknown                                                                           
            rustup component add --toolchain ${RUST_VERSION} cargo clippy rust-analyzer rust-docs rust-src rustfmt                                         

            cargo install leptosfmt
          '';
        };
      }
    );
}
