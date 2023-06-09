require 'rails_helper'

RSpec.describe 'categories/new.html.erb', type: :feature do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }

  it 'creates a new category with a valid name and icon' do
    category = Category.new
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'search.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon.attach(io: file, filename: 'search.png', content_type: 'image/png')
    category.name = 'Test Category'
    expect do
      category.save
    end.to change(Category, :count).by(0)
    expect(category.name).to eq('Test Category')
    expect(category.icon.attached?).to eq(true)
  end



  it 'does not create a new category without a name' do
    category = Category.new
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'search.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon.attach(io: file, filename: 'search.png', content_type: 'image/png')
    expect do
      category.save
    end.not_to change(Category, :count)
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'does not create a new category without an icon' do
    category = Category.new(name: 'Test Category')
    expect do
      category.save
    end.not_to change(Category, :count)
    expect(category.errors[:icon]).to include("can't be blank")
  end
end
