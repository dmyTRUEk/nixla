# **nixla** - nix as a programming language

Love nix? Now you can use it as a programming language also!



## nixla variants:
1. [default](./nixla.sh) - returns a string
2. [nix](./nixla-nix.sh) - returns a nix expression
3. [json](./nixla-json.sh) - returns a json



## Examples:
### Example 1: add input to itself
Create file:
```nix
# add.nix
input: input + input
```
Run it like this:
```bash
$ nixla add.nix Hello
HelloHello
```
Or like this:
```bash
$ echo Hello | nixla add.nix
HelloHello
```


### Example 2: multiply all numbers
```nix
# mul_all_numbers.nix
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
```bash
$ nixla-nix mul_all_numbers.nix 2 3 7
42
```
Or using pipes:
```bash
$ echo 2 3 7 | nixla-nix mul_all_numbers.nix
42
```


### Example 3: import
```nix
# mylib.nix
{
  add = input: input + input;
}
```

```nix
# import-mylib.nix
let
  inherit (import ./mylib.nix) add;
in
  input:
  add input
```
Run it:
```bash
$ nixla import-mylib.nix Hello
HelloHello
```


### Other examples:
- [github:dmyTRUEk/btree-nixla](https://github.com/dmyTRUEk/btree-nixla) - some binary tree operations (such as parsing from text, printing indented, reversing, traversing)
- [github:dmyTRUEk/aoc2024](https://github.com/dmyTRUEk/aoc2024/) - Advent of Code 2024 solutions
