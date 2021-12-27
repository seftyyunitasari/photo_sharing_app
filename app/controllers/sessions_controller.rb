class SessionsController < ApplicationController
  
  skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = 'failed to login'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash.now[:notice] = 'logged out'
    redirect_to new_session_path
  end

end
