require 'rails_helper'

feature 'signup', type: :feature do
  background do
    ActionMailer::Base.deliveries.clear
  end
  scenario "when submit valid form, user must be created" do
#User access top page
  visit root_path
#Jump register form page
  click_link('register_form')
#fill in correct values
  fill_in('user_name', with: 'taro')
  fill_in('user_email', with: 'taro1025@gmail.com')
  fill_in('Password', with: 'taro10255')
  fill_in('Confirmation', with: 'taro10255')
#when submit valid form, user must be created
  expect{
    click_button('create')
  }.to change{ User.count }.by(1)
  expect(ActionMailer::Base.deliveries.size).to eq 1
  user = User.find_by(email:'taro1025@gmail.com')
#with invalid token
  visit edit_account_activation_path("invalid token", email: user.email)
  expect(user.activated?).to be false

#with valid token
  user.update_attribute(:activation_token, User.new_token)
  user.update_attribute(:activation_digest, User.digest(user.activation_token))

  puts "#{user.name}"
  expect(user).to be_valid
  expect(user.authenticated?(user.activation_token, "activation")).to be true
  expect(!user.activated?).to be true
  visit edit_account_activation_path(
        id: user.activation_token,
        email: user.email,
      )
  puts "URL:#{edit_account_activation_path(
        id: user.activation_token,
        email: user.email,
      )}"
  puts "Rootpath#{root_url}"
  #expect(user.activated?).to be true

  expect(page).to have_content 'アカウントが有効化されました'
  end

  scenario "when submit invalid form, user must not be created" do
#User access top page
  visit root_path
#Jump register form page
  click_link('register_form')
#fill in correct values
  fill_in('user_name', with: 'taro')
  fill_in('user_email', with: 'taro1025@gmail.com')
  fill_in('user_password', with: 'taro1025')
  fill_in('user_password_confirmation', with: '')
#when submit valid form, user must be created
  expect{
    click_button('create')
  }.to change{ User.count }.by(0)
  end
end
