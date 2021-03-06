class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  
	protected
	#check if admin
	def check_admin
		unless Admin.find_by(id: session[:admin_id])
			redirect_to login_url, notice: "Please Log In"
		end
	end
end
