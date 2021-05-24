require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  before do
    @user = User.create(email: "aaa@gmail.com", password: "testpass",password_confirmation: "testpass", name: "taro", profile_text: "dfsf", image: "fd" )
  end
  describe "GET /login" do
    it "returns http success" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  scenario 'Login with rememberring' do
    #Login
    get root_path
    get login_path

    post login_path, params: { session: { email: @user.email,password: @user.password,
                                          remember_me: '1' }}



    #Assert
    expect(cookies['remember_token']).not_to be_empty
  end

  scenario 'Login without rememberring' do
    #Login
    get root_path
    get login_path

    post login_path, params: { session: { email: @user.email,password: @user.password,
                                          remember_me: '1' }}
    delete logout_path

    #Assert
    expect(cookies['remember_token']).to be_empty
  end

end
