class ApplicationController < ActionController::Base
  #prevent CSRF attacks by raising an exception
  #for APIs, you may want to use :null_session instead
  protect_from_forgery with: :exception
  
  helper_method: :current_user, :logged_in?
  
  def current_user
    #memoization - save value into instance variable - only hit the database once
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #bang bang turns everything into a boolean
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end
  
end
