class Parser
rule
	a_or_cs
		: a_or_cs a_or_c
		| a_or_c
		;
	a_or_c : 'a' | 'c' ;
end
