class PagesController < ApplicationController
	skip_before_action :verify_authenticity_token, :only => [:handle_unification]

	def home
	end

	def help
	end

	def about
	end

	def handle_unification
		data = params[:problem][:text]
		resp = data
		unifier = RUNIFY::UnificationHandler.new
		unifier.load!(data)
		success = unifier.interpret!
		if success
			resp = unifier.results
			resp = map_to_str resp
		else
			resp = unifier.error_log.to_s
		end
		respond_to do |format|
			msg = { :status => "ok", :message => resp , :html => "<b>...</b>" }
			format.json  { render :json => msg }
		end 
	end

	private
	def map_to_str m
		s = "{ "
		m.each do |k, v|
			s += k.to_str + " --> " + v.to_str + "; "
		end
		s += " }"
		return s
	end
end
