module RUNIFY
	require 'strscan'
	require 'stringio'

	class Tokenizer
		STRING = /[a-zA-Z]/
		LPAREN = /\(/
		RPAREN = /\)/
		COMMA = /,/
		EQUAL = /=/
		WHITESPACE = /(\ |\t)+/
		SEPARATOR = /(\r|\n)+/
		#SEPARATOR = /;/

		def initialize io
			@ss = StringScanner.new io.read 
		end

		def next_token
			loop do 
				return if @ss.eos?

				case 
				when text = @ss.scan(STRING) then return [:STRING, text]
				when text = @ss.scan(LPAREN) then return [:LPAREN, text]
				when text = @ss.scan(RPAREN) then return [:RPAREN, text]
				when text = @ss.scan(COMMA) then return [:COMMA, text]
				when text = @ss.scan(EQUAL) then return [:EQUAL, text]
				when text = @ss.scan(SEPARATOR) then return [:SEPARATOR, text]
				when text = @ss.scan(WHITESPACE) then next
				else
					x = @ss.getch
					return [x,x]
				end
			end 
		end
	end
end
