require 'rails_helper'

feature 'User sign in', %q{
  In order to be able
  еo buy something
  As an user
  I want to be able
  to pay by card
} do

  given(:user) { create(:user) }

  context 'Authenticated user' do
    scenario 'Registered user try to pay by card with valid params', js: true do
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      click_button 'Pay with Card'

      fill_in 'Email', with: "visitor@example.com"
      fill_in 'Card number', :with => '4242424242424242'
      fill_in 'MM / YY', :with => '12/19'
      fill_in 'CVC', :with => '125/n'

      click_button 'Pay 5,00 $'

      expect(page).to have_content("input.invalid")
    end

    scenario 'Registered user try to pay by card with invalid params', js: true do
      visit root_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_on 'Log in'

      click_button 'Pay with Card'

      fill_in 'Email', with: "visitor@example.com"
      fill_in 'Card number', :with => ''
      fill_in 'MM / YY', :with => '12/19'
      fill_in 'CVC', :with => '125/n'

      click_button 'Pay 5,00 $'

      expect(page).to have_css("input.invalid")
    end
  end

  context 'Non-authenticated user' do
    scenario 'Non-authenticated user tries to pay by card' do
      visit root_path
      expect(page).to_not have_button 'Pay with Card'
    end
  end
end
