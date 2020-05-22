# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Authentication', type: :feature do
  def sign_up_and_logout
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing1'
    fill_in 'user_password_confirmation', with: 'testing1'
    click_button 'Sign up'
    click_link 'Log Out'
  end

  scenario 'User can sign in with valid credentials' do
    sign_up_and_logout
    click_link 'Log In'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing1'
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Tester'
  end

  # scenario "User cannot sign in with invalid credentials" do
  #   sign_up_and_logout
  #   click_link "Log In"
  #   fill_in "email", with: "tester.com"
  #   fill_in "password", with: "testing1"
  #   click_button "Login"
  # end
end
