require_relative 'runify'

def ast str = 'x=y'
#RUNIFY.load str
RUNIFY.load 'X=Y
Y=f(x)'
end

def unif prob
	unif = RUNIFY::Unification.new
	unif.unify_system! prob
end

def test2
	unif ast
end

def test
	data = 'x = f(y,z)'
	unifier = RUNIFY::UnificationHandler.new
	unifier.load!(data)
	unifier.interpret!
	map_to_str unifier.results
end

def map_to_str m
	s = ""
	m.each do |k, v|
		s += k.to_str + " => " + v.to_str + "\n"
	end
	return s
end
