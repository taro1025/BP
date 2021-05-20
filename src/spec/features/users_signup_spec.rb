require 'rails_helper'

feature 'signup', type: :feature do
  scenario "when submit valid form, user must be created" do
#User access top page
  visit root_path
#Jump register form page
  click_link('register_form')
#fill in correct values
  fill_in('user_name', with: 'taro')
  fill_in('user_email', with: 'taro1025@gmail.com')
  fill_in('user_password', with: 'taro1025')
  fill_in('user_password_confirmation', with: 'taro1025')
#when submit valid form, user must be created
  expect{
    click_button('create')
  }.to change{ User.count }.by(1)
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
