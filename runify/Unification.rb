module RUNIFY
	class Unification
		def initialize 
			@unifier = {}
		end

		def unify_system! equations_list
			equations_list.each do |eq|
				unify_equation! eq
			end
			return @unifier
		end

		def clear!
			@unifier.clear
		end

		class UnificationError < StandardError
		end

		private
			
			def unify_equation! equation
				s = equation[0]
				t = equation[1]

				if s.is_a? VTerm then
					s = substitute s, @unifier
				end

				if t.is_a? VTerm then
					t = substitute t, @unifier
				end


				if t.is_a? VTerm and s.is_a? VTerm and s.label == t.label then
				elsif s.is_a? FTerm and t.is_a? FTerm then
					if s.label == t.label and s.args.size() == t.args.size() then
						(0..s.args.size() - 1).each do |i|
							unify_equation! [s.args[i], t.args[i]]
						end
					else
						# Symbol Clash
						raise UnificationError, 'Symbol Clash'
					end
				elsif s.is_a? FTerm then
					unify_equation! [t, s]
				elsif s.occurs? t
					# Occurs Check
					raise UnificationError, 'Occurs Check'
				else
					mapping = {s => t}
					update! mapping
				end
					
			end

			def substitute t, mapping
				case t
				when RUNIFY::VTerm then
					mapping.each do |k, v|
						if t.label == k.label
							return v
						end
					end
				when RUNIFY::FTerm then
					t.args = t.args.map do |arg|
						arg = substitute arg, mapping
					end
				end	
				return t
			end

			def update! mapping
				@unifier.each do |x, t|
					@unifier[x] = substitute t, mapping
				end
				#@unifier.each do |x, t|
					#if x.label == t.label and t.is_a? VTerm then
						#@unifier.delete x
					#end
				#end
				@unifier.merge! mapping

			end


	end
end
