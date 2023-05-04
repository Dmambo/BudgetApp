require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }


  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:icon) }
    it { should belong_to(:author) }
    it { should have_many(:expenses) }
    it 'is valid with a name and an icon' do
      category = Category.new(name: 'Test', icon: fixture_file_upload('search.png', 'image/png'), author_id: user.id)
      expect(category).to be_valid
    end
    it 'is invalid without a name' do
      category = Category.new(icon: fixture_file_upload('search.png', 'image/png'), author_id: user.id)
      expect(category).to be_invalid
      expect(category.errors[:name]).to include("can't be blank")
    end
    it 'is invalid without an icon' do
      category = Category.new(name: 'Test', author_id: user.id)
      expect(category).to be_invalid
      expect(category.errors[:icon]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      category = Category.new(name: 'Test', icon: fixture_file_upload('search.png', 'image/png'), author_id: user.id)
      expect(category.author).to eq(user)
    end
    it 'has many expenses' do
      expense1 = Expense.create(name: 'text expense 1', amount: 10, user_id: user.id)
      expense2 = Expense.create(name: 'text expense 2', amount: 20, user_id: user.id)
      expect(user.expenses).to eq([])
    end
  end

  describe '#total_amount' do
    it 'returns the sum of expenses amount for the category' do
      category = Category.create(name: 'Test', icon: fixture_file_upload('search.png', 'image/png'), user_id: user.id)
      expense1 = Expense.new(name: 'text expense 1', amount: 10, user_id: user.id)
      expense1.save
      category_expense = CategoryExpense.create(category: category.id, expense: expense1.id)
      expense2 = Expense.new(name: 'text expense 2', amount: 20, user_id: user.id)
      expense2.save
      category_expense = CategoryExpense.create(category: category.id, expense: expense2.id)
      expect(category.total_amount).to eq(0)
    end
  end
end
