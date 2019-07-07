require 'rails_helper'

feature 'User sign in', %q{
  In order to be able
  еo buy something
  As an user
  I want to be able
  to pay with ACH
} do

  given(:user) { create(:user) }

  context 'Authenticated user' do
    scenario 'Registered user try to pay with ACH with valid params', js: true do
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      click_button 'Pay with ACH'

      fill_in 'Full Legal Name', with: "Name"
      fill_in 'Routing Number', with: "111000000"
      fill_in 'Account Number', with: "000123456789"

      click_button 'Add bank account'

      fill_in 'Deposit amount 1', with: "32"
      fill_in 'Deposit amount 2', with: "45"

      click_button 'Verify bank account'

      click_button 'Make a payment'
      expect(page).to have_content("Thanks for you payment")

    end
  end

  context 'Non-authenticated user' do
    scenario 'Non-authenticated user tries to pay with ACH' do
      visit root_path
      expect(page).to_not have_button 'Pay with ACH'
    end
  end
end
