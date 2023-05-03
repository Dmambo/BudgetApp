class CategoriesController < ApplicationController
  before_action :authenticate_user!
  def index
    @user = current_user
    @categories = @user.categories.all
  end

  def new
    @category = Category.new
  end

  def create
    @user = current_user
    @category = current_user.categories.new(category_params)

    if @category.save
      redirect_to categories_path, notice: 'Category created successfully.'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :icon, :icon_name).merge(user_id: current_user.id)
  end  
end