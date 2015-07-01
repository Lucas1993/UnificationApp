module RUNIFY
	class UnificationHandler
		attr_reader :results
		attr_reader :error_log

		def initialize
			@parser = nil
			@results = ""
			@error_log = ""
			@unifier = RUNIFY::Unification.new
		end

		def load! str
			io_str = StringIO.new str
			tok     = RUNIFY::Tokenizer.new io_str
			@parser  = RUNIFY::Parser.new tok
			return
		end

		def interpret!
			if @parser != nil and @unifier != nil
				@unifier.clear!
				begin
					ast = @parser.parse!
					@results = @unifier.unify_system!(ast)
					return true
				rescue ParseError => error_msg
					@error_log = error_msg
					puts @error_log
					@error_log = "Syntax Error!"
					return false
				rescue RUNIFY::UnificationError => error_msg
					@error_log = error_msg
					puts @error_log
					@error_log = "Unification failure"
					return false
				end
			end
		end
	end
end
