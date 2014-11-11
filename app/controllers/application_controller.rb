class ApplicationController < ActionController::Base
  #prevent CSRF attacks by raising an exception
  #for APIs, you may want to use :null_session instead
  protect_from_forgery with: :exception
  
  
  
  helper_method :current_user, :logged_in?
  #makes control methods available to view templates
  
  private
  
  def current_user
    #memoization - save value into instance variable - only hit the database once
    #if instance variable exists, don't run the code on the right 
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
    #User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    #bang bang turns everything into a boolean   
    #if current user == true
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end
 
  def require_admin
    access_denied unless logged_in? and current_user.admin?
  end
    
  def access_denied
    flash[:error] = "You can't do that."
    redirect_to root_path
  end
    
end
