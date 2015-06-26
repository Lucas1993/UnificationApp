module Tokenizer
	require 'strscan'
	require 'stringio'
	class Tokenizer
		NAME = /[a-zA-Z]/
		NUMBER = /[0-9]/
		LPAREN = /\(/
		RPAREN = /\)/
		EQUAL = /=/
		

		def initialize io
			@ss = StringScanner.new io.read 
		end

		def next_token
			return if @ss.eos?

			case 
			when text = @ss.scan(NAME) then [:NAME, text]
			when text = @ss.scan(NUMBER) then [:NUMBER, text]
			when text = @ss.scan(LPAREN) then [:LPAREN, text]
			when text = @ss.scan(RPAREN) then [:RPAREN, text]
			when text = @ss.scan(EQUAL) then [:EQUAL, text]
			else
				x = @ss.getch
				[x,x]
			end
			
		end
	end
end
