class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user, :current_site

  private

  def current_site
    return @current_site if defined?(@current_site)
	  	@current_site = Site.find_by_domain(request.domain)
  end

	def requires_authentication
		unless current_user
			log_user_in
    	end
	end
	
	def current_user_session
		return @current_user_session if defined?(@current_user_session)
	  	@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
	  	@current_user = current_user_session && current_user_session.record
	end
	
	def store_location
    	session[:return_to] = request.path
  	end

	def redirect_back_or_default(default)
		redirect_to(session[:return_to] || default)
		session[:return_to] = nil
	end

	def log_user_in
		store_location
	    flash[:notice] = "You must be logged in to access this page"
	    redirect_to login_url
	    return false
	end
	
	def render_404
		render :file => "#{Rails.root}/public/404.html", :status => "404 Not Found"
	end
end
