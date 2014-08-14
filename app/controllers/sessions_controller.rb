class SessionsController < ApplicationController


  def new
	# prevent admin to double login 
	if session[:admin_id]
		redirect_to root_url, notice: "Already logged in"
	end
  end

  def create
	admin = Admin.find_by(name: params[:name])
	if admin and admin.authenticate(params[:password])
		session[:admin_id] = admin.id
		redirect_to root_url,notice: "Welcome #{admin.name}! The footer has now admin links. You can change, create, or delete Courses, Styles, or Studios on the dedicated pages!"
	else
		redirect_to login_url, notice:"Invalid Name/Password"
	end
  end

  def destroy
	  session[:admin_id] = nil
	  redirect_to root_url, notice: "Logged Out"
  end
end
