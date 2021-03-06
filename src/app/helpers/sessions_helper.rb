module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  #ブラウザを切っても覚えとくよ
  def remember(user)
    #文字列を生成とし、ハッシュかしたのをDB、
    user.remember
    #生成した文字列をそのままのをクッキーに
    cookies.permanent[:remember_token] = user.remember_token
    #idをクッキーにいれる
    cookies.permanent.signed[:user_id] = user.id
  end

  def current_user
    if user_id = session[:user_id]
      @current_user ||= User.find_by(id: user_id)
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token], "remember")
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user) if logged_in?
    session.delete(:user_id)
    @current_user = nil
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
end
