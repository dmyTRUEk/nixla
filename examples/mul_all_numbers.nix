let # declarations
	inherit (builtins) # imports
		filter
		split
		foldl'
		fromJSON
	;
	split_ = sep_regex: str:
		filter # filter out matched parts
			(el: el != []) # is matched
			(split sep_regex str);
in # "main" function:
	input:
	foldl'
		(acc: el: acc * el) # mul
		1 # start from one
		(map
			fromJSON # may work as toInt, lmao
			(split_ " " input)
		)
