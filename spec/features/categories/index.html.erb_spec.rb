require 'rails_helper'

RSpec.describe 'categories/index.html.erb', type: :feature do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Groceries', icon: fixture_file_upload('search.png', 'image/png')) }

  let(:expense) { Expense.create(name: 'Test', amount: 10, author: user) }
  let(:category_expense) { CategoryExpense.create(category:, expense:) }

  before do
    sign_in user
    visit categories_path
  end

  it 'displays all categories' do
    expect(page).to have_content('No categories available.')
    expect(page).to have_content('CATEGORIES')
  end

  it 'should show the picture for each category' do
    expect(page).to have_css('img')
  end

  it 'redirects to new category form when clicking on "Add new category" button' do
    click_on 'Add a new category'
    expect(page).to have_current_path(new_category_path)
  end
end
