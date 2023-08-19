require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  let(:user) { User.create(name: 'John Doe', email: 'test@example.com', password: 'password') }
  let(:category) { Category.create(name: 'Groceries', icon: 'groceries-icon', user:) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new Expense' do
      get :new
      expect(assigns(:expense)).to be_a_new(Expense)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { { expense: { name: 'Item 1', amount: 20, category_id: ['', category.id.to_s] } } }

    it 'creates a new expense' do
      expect do
        post :create, params: valid_params
      end.to change(Expense, :count).by(1)
    end

    it 'redirects to the category show page' do
      post :create, params: valid_params
      expect(response).to redirect_to(category_path(category))
    end

    it 'creates multiple expenses for different categories' do
      category2 = Category.create(name: 'Entertainment', icon: 'entertainment-icon', user:)
      valid_params[:expense][:category_id] = ['', category.id.to_s, category2.id.to_s]

      expect do
        post :create, params: valid_params
      end.to change(Expense, :count).by(2)
    end
  end
end
