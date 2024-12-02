let
	inherit (import ./mylib.nix) add;
in
	input:
	add input
