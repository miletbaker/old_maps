class UserSessionsController < ApplicationController
	layout 'auth'
	
	
  def new
		@user_session = UserSession.new
  end

	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			redirect_back_or_default current_user.logged_in_url
		else
			render :action => 'new'
		end
	end
	
  def destroy
		return unless current_user_session
		current_user_session.destroy
  end

end
