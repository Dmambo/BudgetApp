require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  include ActionDispatch::TestProcess
  let(:user) { FactoryBot.create(:user, email: Faker::Internet.unique.email) }
  let(:category) do
    FactoryBot.create(:category, user_id: user.id, icon: fixture_file_upload('search.png', 'image/png'))
  end
  let(:expense) { FactoryBot.create(:expense, author: user) }
  let(:category_expense) { FactoryBot.create(:category_expense, category:, expense:) }

  before do
    user.save
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index, params: { category_id: category.id }
      expect(response).to render_template(:index)
    end

    it 'assigns @expenses with user expenses' do
      get :index, params: { category_id: category.id }
      expect(assigns(:expenses)).to eq(category.expenses)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new, params: { category_id: category.id }
      expect(response).to render_template(:new)
    end

    it 'assigns a new expense to @expense' do
      get :new, params: { category_id: category.id }
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end
end
