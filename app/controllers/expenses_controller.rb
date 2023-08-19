class ExpensesController < ApplicationController
  def new
    @expense = Expense.new
  end

  def create
    @categories = params[:expense][:category_id].drop(1)
    @categories.each do |category|
      @expense = Expense.new(name: params[:expense][:name], amount: params[:expense][:amount],
                             category_id: category.to_i, user_id: current_user.id)
      @expense.save
    end
    redirect_to categories_path
  end

  private

  def entity_params
    params.require(:expense).permit(:category_id, :amount, :name)
  end
end
