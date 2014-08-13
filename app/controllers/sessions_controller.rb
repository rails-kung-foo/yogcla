class SessionsController < ApplicationController


  def new
  end

  def create
	admin = Admin.find_by(name: params[:name])
	if admin and admin.authenticate(params[:password])
		session[:admin_id] = admin.id
		redirect_to root_url,notice: "Welcome #{admin.name} ! The footer has now admin links.
			Change Course, Styles, etc direct in the dedicatet lists."
	else
		redirect_to login_url, notice:"Invalid Name/Password"
	end
  end

  def destroy
	  session[:admin_id] = nil
	  redirect_to root_url, notice: "Logged Out"
  end
end
