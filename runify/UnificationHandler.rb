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
			tok     = RUNIFY::Tokenizer.new str
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
					return false
				end
			end
		end
	end
end
