class RUNIFY::Parser
token STRING LPAREN RPAREN EQUAL COMMA SEPARATOR
rule
	problem_set : equations { val[0] };
	equations 
			: equation { result = [val[0]] }
			| equation seps equations { result = val[2].unshift(val[0]) };

	seps : SEPARATOR seps | SEPARATOR;

	equation : term EQUAL term { result = [val[0], val[2]] };

	term
		: var {result = val[0]}
		| fun {result = val[0]}
		;

	label : STRING;

	var : label { result = VTerm.new(val[0]) };

	fun : label LPAREN args RPAREN { result = FTerm.new(val[0], val[2]) }

	args 
		: term { result = [val[0]] }
		| term COMMA args { result = [val[0]] + val[2] };

end

---- inner

	def initialize tokenizer
		@tokenizer = tokenizer
		super()
	end

	def next_token
		@tokenizer.next_token
	end

	def parse!
		do_parse
	end

