require 'rails_helper'

RSpec.describe 'splash/splash.html.erb', type: :feature do
  before do
    visit root_path
  end

  it 'renders successfully' do
    expect(page).to have_content('ADE-BUDGET')
    expect(page).to have_content('LOG IN')
    expect(page).to have_content('SIGN UP')
  end

  it 'contains LOG IN and SIGN UP links' do
    expect(page).to have_link 'LOG IN'
    expect(page).to have_link 'SIGN UP'
  end

  it 'redirects to the LOG IN page' do
    click_link 'LOG IN'
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'redirects to the SIGN UP page' do
    click_link 'SIGN UP'
    expect(page).to have_current_path(new_user_registration_path)
  end
end
