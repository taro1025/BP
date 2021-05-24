require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, type: :helper do
  before do
    @user = User.create(email: "aaa@gmail.com", password: "testpass",password_confirmation: "testpass", name: "taro", profile_text: "dfsf", image: "fd" )
    remember @user
  end
  describe 'when have cookie have not session' do
    it 'current_user retrns user ' do
      expect(@user).to eq current_user
      expect(logged_in?).to eq true
    end
  end
  describe 'when remember digest is wrong' do
    it 'return current_user nil' do
      @user.update_attribute(:remember_digest, User.digest(User.new_token))
      expect(current_user).to be nil
    end
  end
end
