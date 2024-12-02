FILENAME=$1

# step 1: ensure given file is valid nix expression:
nix \
	--extra-experimental-features pipe-operators \
	eval \
	--impure \
	--file \
	$FILENAME \
	> /dev/null

# step 2: remove filename from all other cli args
shift 1

# step 3: run nix function on the input:
nix \
	--extra-experimental-features pipe-operators \
	eval \
	--impure \
	--json \
	--expr \
	"($(cat $FILENAME)
) \"$(echo $@)\""
