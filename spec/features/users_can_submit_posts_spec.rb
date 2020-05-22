# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Timeline', type: :feature do
  def sign_up_and_create
    visit '/'
    click_link 'Sign Up'
    fill_in 'user_name', with: 'Tester'
    fill_in 'user_username', with: 'tester1'
    fill_in 'user_email', with: 'tester@mail.com'
    fill_in 'user_password', with: 'testing1'
    fill_in 'user_password_confirmation', with: 'testing1'
    click_button 'Sign up'
    fill_in 'post_message', with: 'Hello, world!'
    click_button "Post to Tester's wall"
  end

  scenario 'Can submit posts and view them' do
    sign_up_and_create
    expect(page).to have_content('Hello, world!')
  end

  scenario 'Cannot make a post unless signed in' do
    visit '/posts'
    expect(page).to_not have_link 'New Post'
  end

  scenario 'Can submit posts and see who created it' do
    sign_up_and_create
    expect(page).to have_content('Hello, world!')
    expect(page).to have_content('Tester')
  end

  scenario "You cannot see others users posts if you're not signed in." do
    sign_up_and_create
    click_link 'Log Out'
    expect(page).not_to have_content('Hello, world!')
    expect(page).not_to have_content('Tester')
  end
end
