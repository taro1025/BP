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
end
