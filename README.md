# nixla - nix as a programming language

Love nix? Now you can use it as a programming language also!



## nixla variants:
1. default - returns a string
2. nix - returns a nix expression
3. json - returns a json



## Examples:
### Example 1: add input to itself
Create file [add.nix](./examples/add.nix):
```nix
input: input + input
```
Run it like this:
```
$ nixla add.nix Hello
HelloHello
```


### Example 2: multiply all numbers
[mul_all_numbers.nix](./examples/mul_all_numbers.nix):
```nix
let
	inherit (builtins) filter split foldl' fromJSON;
	split_ = sep_regex: str:
		filter
			(el: el != [])
			(split sep_regex str);
in
	input:
	foldl'
		(acc: el: acc * el)
		1
		(map
			fromJSON # works as toInt
			(split_ " " input)
		)
```
Run it:
```
$ nixla-nix mul_all_numbers.nix 2 3 7
42
```
