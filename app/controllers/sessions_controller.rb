class SessionsController<ApplicationController
  def new
    
  end
  
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You are now logged in."
      redirect_to_root_path
    else
      flash[:error] = "There's something wrong with your username or password."
      redirect_to register_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out."
    redirect_to_root_path
  end
end
