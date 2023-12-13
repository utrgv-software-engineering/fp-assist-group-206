require 'rails_helper'
# For issue RAILAST206-22
RSpec.feature 'Authentication', type: :feature do
  scenario 'non-signed-in users should only have access to the login page' do
    visit root_path
    expect(page).to have_content('Log in') # Assuming your login page has this content

    visit '/users/sign_in' # Replace with your protected path
    expect(page).to have_content('Log in') # Non-signed-in users should be redirected to login
  end
end
