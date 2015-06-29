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
		else
			resp = unifier.error_log
		end
		respond_to do |format|
			msg = { :status => "ok", :message => resp , :html => "<b>...</b>" }
			format.json  { render :json => msg }
		end 
	end
end
