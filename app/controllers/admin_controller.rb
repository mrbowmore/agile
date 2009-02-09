class AdminController < ApplicationController
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:action => "index")
      else
        flash.now[:notice] = "invalid user/password"
      end
    end
  end
  
  def logout
    session[:user_id] = nil
    flash[:notice] = "logged out"
    redirect_to(:action  => "login")
  end

  def index
    @total_orders = Order.count
  end

end
