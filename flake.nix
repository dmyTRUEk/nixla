{
	outputs = { nixpkgs, self }:
	let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
	in
	{
		packages.${system} = {
			default = self.packages.${system}.nixla;
			nixla = pkgs.writeShellScriptBin "nixla" (builtins.readFile ./nixla.sh);
			nixla-nix = pkgs.writeShellScriptBin "nixla-nix" (builtins.readFile ./nixla.sh);
			nixla-json = pkgs.writeShellScriptBin "nixla-json" (builtins.readFile ./nixla.sh);
		};

		apps.${system} = {
			default = {
				type = "app";
				program = pkgs.lib.getExe self.packages.${system}.default;
			};
			nixla = {
				type = "app";
				program = pkgs.lib.getExe self.packages.${system}.nixla;
			};
			nixla-nix = {
				type = "app";
				program = pkgs.lib.getExe self.packages.${system}.nixla-nix;
			};
			nixla-json = {
				type = "app";
				program = pkgs.lib.getExe self.packages.${system}.nixla-json;
			};
		};
	};
}
