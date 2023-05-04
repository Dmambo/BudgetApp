class ExpensesController < ApplicationController
  def index
    @category = Category.find(params[:category_id])
    @category_expenses = @category.category_expenses
    @expenses = Expense.joins(:category_expenses, :categories)
      .where('expenses.id = category_expenses.expense_id')
      .where('categories.id = category_expenses.category_id')
      .where('categories.id = ?', params[:category_id]).order('expenses.created_at DESC')
    @total_amount = @expenses.sum(:amount)
  end

  def new
    @category = Category.find(params[:category_id])
    @expense = Expense.new
    @categories = current_user.categories
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.author = current_user

    if @expense.save
      @category_expense = CategoryExpense.new(category_id: params[:category_id], expense_id: @expense.id)
      @category_expense.save
      redirect_to category_expenses_path(@category_expense.category), notice: 'Transaction created successfully.'
    else
      render :new
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :amount).merge(user_id: current_user.id)
  end
end
