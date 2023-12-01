{
  # inspired by: https://serokell.io/blog/practical-nix-flakes#packaging-existing-applications
  description = "A Hello World in Haskell with a dependency and a devShell";
  inputs.nixpkgs.url = "nixpkgs";
  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux" "x86_64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems (system: f system);
    nixpkgsFor = forAllSystems (system:
      import nixpkgs {
        inherit system;
      });
  in {
    devShell = forAllSystems (system: let
      haskellPackages = nixpkgsFor.${system}.haskellPackages;
    in
      haskellPackages.shellFor {
        packages = p: [];
        buildInputs = with haskellPackages; [
          haskell-language-server
          ghcid
          cabal-install
        ];
      });
  };
}
