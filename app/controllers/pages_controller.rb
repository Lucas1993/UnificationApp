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
		respond_to do |format|
			msg = { :status => "ok", :message => data , :html => "<b>...</b>" }
			format.json  { render :json => msg } # don't do msg.to_json
		end 
	end
end
