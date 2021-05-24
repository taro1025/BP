require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  before do
    @user = User.create(
        email: "aaa@gmail.com",
        password: "testpass",password_confirmation: "testpass",
        name: "taro", profile_text: "dfsf",
        image: "fd",activated: true, activated_at: Time.zone.now )
    @user.activation_token = User.new_token
  end
  describe "account_activation" do
    let(:mail) { UserMailer.account_activation(@user) }

    it "renders the headers" do
      expect(mail.subject).to eq("アカウントを有効化しましょう")
      expect(mail.to).to eq(["#{@user.email}"])
      expect(mail.from).to eq(["game4967@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
      expect(mail.body.encoded).to match(CGI.escape(@user.email))
    end
  end

  describe "password_reset" do
    let(:mail) { UserMailer.password_reset }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["game4967@gmail.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
