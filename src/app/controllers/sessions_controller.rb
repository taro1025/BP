class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user): forget(user)
        flash[:success] = "Login success"
        redirect_to root_path
      else
        flash[:worning] = "アカウントはまだ無効です。有効化するには届きましたメールからリンクにアクセスしてください"
        redirect_to root_path
      end
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out #if logged_in?
    redirect_to root_path
  end

  private
      def a
      end

end
