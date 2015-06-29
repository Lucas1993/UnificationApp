module RUNIFY
	#require 'stringio'
	def self.load_io(input)
		tok     = RUNIFY::Tokenizer.new input
		parser  = RUNIFY::Parser.new tok
		parser.parse!
	end

	def self.load(str)
		load_io StringIO.new str
	end
end
