module RUNIFY
	require 'strscan'
	require 'stringio'

	class Tokenizer
		STRING = /[a-zA-Z]/
		LPAREN = /\(/
		RPAREN = /\)/
		COMMA = /,/
		EQUAL = /=/
		SEPARATOR = /(\r|\n)+/
		#SEPARATOR = /;/

		def initialize io
			@ss = StringScanner.new io.read 
		end

		def next_token
			return if @ss.eos?

			case 
			when text = @ss.scan(STRING) then [:STRING, text]
			when text = @ss.scan(LPAREN) then [:LPAREN, text]
			when text = @ss.scan(RPAREN) then [:RPAREN, text]
			when text = @ss.scan(COMMA) then [:COMMA, text]
			when text = @ss.scan(SEPARATOR) then [:SEPARATOR, text]
			when text = @ss.scan(EQUAL) then [:EQUAL, text]
			else
				x = @ss.getch
				[x,x]
			end
			
		end
	end
end
