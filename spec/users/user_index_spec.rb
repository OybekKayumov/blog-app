require 'rails_helper'

RSpec.describe 'Creating a user', type: :users do
  scenario 'valid inputs' do
    visit new_users_path
    fill_in 'Name', with: 'Misha'
    click_on 'Create User'
    visit users_path
    expect(page).to have_content('Misha')
  end
end
