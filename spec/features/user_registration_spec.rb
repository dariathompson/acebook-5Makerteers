# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Timeline', type: :feature do
  scenario 'User can signup with valid credentials' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing1'
    fill_in 'user_password_confirmation', with: 'testing1'
    click_button 'Sign up'
    expect(page).to have_content('Tester')
  end

  scenario 'User cannot signup with invalid email' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'testermail'
    fill_in 'user_password', with: 'testing1'
    fill_in 'user_password_confirmation', with: 'testing1'
    click_button 'Sign up'
    expect(page).to have_content('is invalid')
  end

  scenario 'User cannot signup with invalid password' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing1233445567899865434'
    fill_in 'user_password_confirmation', with: 'testing1233445567899865434'
    click_button 'Sign up'
    expect(page).to have_content('is too long')
  end

  scenario 'users are signed in when they sign up' do
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing'
    fill_in 'user_password_confirmation', with: 'testing'
    click_button 'Sign up'
    expect(page).to have_content('Tester')
  end
end
