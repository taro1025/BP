require 'rails_helper'

feature 'logout', type: :feature do
  background 'Login' do
    visit root_path
    click_link 'ログイン'
    user = User.new(email: "aaa@gmail.com", password: "testpass",password_confirmation: "testpass", name: "taro", profile_text: "dfsf", image: "fd" )
    expect(user.save).to be true
    fill_in 'Email', with: 'aaa@gmail.com'
    fill_in 'Password', with: 'testpass'
    click_button 'Log in'
  end

  context 'user going to logout' do
    scenario 'it success' do
      click_link 'ログアウト'
      expect(page).not_to have_selector 'a', text: 'ログアウト'
      expect(page).to have_selector 'a', text: 'ログイン'
    end
  context 'user going to logout 2 times in a row'
    scenario 'No raising error' do
      click_link 'ログアウト'
      page.driver.submit :delete, "/logout", {}
      expect(page).not_to have_selector 'a', text: 'ログアウト'
      expect(page).to have_selector 'a', text: 'ログイン'
    end
  end
end
