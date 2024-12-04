# nixla - nix as a programming language



# set nixla type:

NIXLA=""
NIXLA_NIX=""
NIXLA_JSON=""

script_name=$(basename "$0")
case "$script_name" in
	"nixla" | "nixla.sh")
		NIXLA="--raw"
		;;
	"nixla-nix" | "nixla-nix.sh")
		NIXLA_NIX=""
		;;
	"nixla-json" | "nixla-json.nix")
		NIXLA_JSON="--json"
		;;
	*)
		echo "Unknown entry-point: $script_name"
		echo "Try using 'nixla', 'nixla-nix' or 'nixla-json'."
		exit 1
		;;
esac



# get filename
FILENAME=$1

# check filename
if [ -z "$FILENAME" ]; then
	echo "File name was not provided!"
	exit 1
fi

# check that given file is a valid nix expression:
nix \
	--extra-experimental-features pipe-operators \
	eval \
	--impure \
	--file \
	$FILENAME \
	> /dev/null

# remove filename from all other cli args
shift 1



# Collect the input:

# check if arguments is provided
if [ "$#" -gt 0 ]; then
	input="$@"

# check if there is input from stdin
elif [ ! -t 0 ]; then
	# src: https://stackoverflow.com/questions/6980090/how-to-read-from-a-file-or-standard-input-in-bash#7045517
	input="$(cat)"

else
	echo "No input provided!" >&2
	exit 1
fi

# prevent nix string interpolation
input=$(echo "$input" | sed 's/${/$${/g')



# run nix function on the input:
nix \
	--extra-experimental-features pipe-operators \
	eval \
	--option max-call-depth 1000000 \
	--impure \
	$NIXLA \
	$NIXLA_NIX \
	$NIXLA_JSON \
	--expr \
	"($(cat $FILENAME)
) \"$input\""
