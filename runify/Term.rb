module RUNIFY

class Term
	def initialize
		raise "Abstract class!"
	end
end	

class VTerm < Term
	def initialize name
		@label = name
	end
end

class FTerm < Term
	def initialize name, args
		@label = name
		@args = args
	end
end


end
