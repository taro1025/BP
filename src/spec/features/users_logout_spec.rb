require 'rails_helper'

feature 'logout', type: :feature do
  scenario 'when log out with valid form , it success' do
    #Login
    visit root_path
    click_link 'ログイン'
    user = User.new(email: "aaa@gmail.com", password: "testpass",password_confirmation: "testpass", name: "taro", profile_text: "dfsf", image: "fd" )
    expect(user.save).to be true
    fill_in 'Email', with: 'aaa@gmail.com'
    fill_in 'Password', with: 'testpass'
    click_button 'Log in'

    #Logout
    click_link 'ログアウト'

    #Asseert
    expect(page).not_to have_selector 'a', text: 'ログアウト'
    expect(page).to have_selector 'a', text: 'ログイン'
  end
end
