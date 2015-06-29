require_relative 'runify'

def ast str = 'x=y'
#RUNIFY.load str
RUNIFY.load 'x=f(y,z)
  
z=y'
end

def unif prob
	unif = RUNIFY::Unification.new
	unif.unify_system! prob
end

def test
	p = ast
	unif p
end
