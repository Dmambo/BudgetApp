require 'rails_helper'

RSpec.describe SplashController, type: :controller do
  describe 'GET #splash' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the splash template' do
      get :splash
      expect(response).to render_template(:splash)
    end
  end
end