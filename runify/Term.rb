module RUNIFY

class Term
	def initialize
		raise "Abstract class!"
	end
end	

class VTerm < Term
	attr_reader :label
	def initialize name
		@label = name
	end

	def occurs? f
		if f.is_a? VTerm
			if f.label == self.label
				return true
			else
				return false
			end
		else
			oc = false
			f.args.each do |arg|
				oc |= self.occurs? arg	
			end
			return oc
		end
	end
end

class FTerm < Term
	attr_reader :label, :args
	attr_writer :args
	def initialize name, args
		@label = name
		@args = args
	end
end


end
