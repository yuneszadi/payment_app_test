require 'rails_helper'

 feature 'User sign out', %q{
  In order to exit
  as an authorized user,
  I want to be able to sign out
} do

  given(:user) { create(:user) }

   scenario 'Authintacated user try to sign out' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully'

    click_on 'Log out'

    expect(page).to have_content 'You need to sign in or sign up before continuing'
  end
end
