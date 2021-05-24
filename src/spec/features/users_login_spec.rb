require 'rails_helper'

feature 'login', type: :feature do
  scenario 'when miss login, flash display 1 time' do
    visit root_path

    click_link 'ログイン'

    fill_in 'Email', with: 'invalid@xxx'
    fill_in 'Password', with: 'aa'

    click_button 'Log in'

    expect(page).to have_content 'Invalid email/password combination'

    visit root_path

    expect(page).not_to have_content 'Invalid email/password combination'
  end

  scenario 'when login success' do
    #Login
    visit root_path
    click_link 'ログイン'
    user = User.new(
        email: "aaa@gmail.com",
        password: "testpass",password_confirmation: "testpass",
        name: "taro", profile_text: "dfsf",
        image: "fd",activated: true, activated_at: Time.zone.now )
    expect(user.save).to be true
    fill_in 'Email', with: 'aaa@gmail.com'
    fill_in 'Password', with: 'testpass'
    click_button 'Log in'

    #Assert
    expect(page).not_to have_content 'Invalid email/password combination'
    expect(page).to have_content "Login success"
  end
end
