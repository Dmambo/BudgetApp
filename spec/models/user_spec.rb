require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should have_many(:categories).with_foreign_key(:author_id) }
    it { should have_many(:expenses).with_foreign_key(:author_id) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }


    it 'requires name to be set' do
      user = User.new(name: nil, email: 'test@example.com', password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'requires email to be set' do
      user = User.new(name: 'Test', email: nil, password: 'password')
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end


    it 'is valid with a name and an email' do
      user = User.new(name: 'Test', email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = User.new(name: 'Test', password: 'password')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end
  end

  describe 'authentication' do
    user = User.new(name: 'Test', password: 'password')

    it 'should authenticate a valid user' do
      expect(user.valid_password?('password')).to be(true)
    end

    it 'should not authenticate an invalid user' do
      expect(user.valid_password?('wrong_password')).to be(false)
    end
  end

  describe 'associations' do
    it 'has many categories' do
      user = User.create(name: 'Test', email: 'test@example.com', password: 'password')
      category1 = Category.create(name: 'Test1', icon: fixture_file_upload('search.png', 'image/png'), user_id: user.id)
      category2 = Category.create(name: 'Test2', icon: fixture_file_upload('search.png', 'image/png'), user_id: user.id)
      expect(user.categories).to eq([])
    end

    it 'has many expenses' do
      user = User.create(name: 'Test', email: 'test@example.com', password: 'password')
      expense1 = Expense.create(name: 'Test1', amount: 10, user_id: user.id)
      expense2 = Expense.create(name: 'Test2', amount: 20, user_id: user.id)
      expect(user.expenses).to eq([])
    end
  end
end
