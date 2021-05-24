# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    get_user
    @user.activation_token = User.new_token
    UserMailer.account_activation(@user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

  private
  def get_user
    @user = User.create(
        email: "aaa@gmail.com",
        password: "testpass",password_confirmation: "testpass",
        name: "taro", profile_text: "dfsf",
        image: "fd",activated: true, activated_at: Time.zone.now )
  end
end
