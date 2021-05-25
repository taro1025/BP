class AccountActivationsController < ApplicationController
  def edit
    #Userをemailアドレスから見つける
    user = User.find_by(email: params[:email])
    if user && user.authenticated?(params[:id], "activation") && !user.activated?
      user.activate
      log_in user
      flash[:success] = "アカウントが有効化されました"
      redirect_to root_path
    else
      flash[:danger] = "リンクが違いますねえ"
      redirect_to root_path
    end
  end
end
