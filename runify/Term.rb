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

	def to_str
		self.label
	end
end

class FTerm < Term
	attr_reader :label, :args
	attr_writer :args
	def initialize name, args = []
		@label = name
		@args = args
	end
	def to_str
		s = ""
		s += self.label
		if @args.length > 0
			s += "("
			@args.each do |arg|
				s += arg.to_str + ","
			end
			if s.end_with? ',' then
				s = s[0..-2]
			end
			s += ")"
		end
		return s
	end
end


end
