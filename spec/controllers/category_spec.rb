require 'rails_helper'
require 'devise'

RSpec.describe CategoriesController, type: :controller do
  let(:user) { User.create!(name: 'Test User', email: 'test@example.com', password: 'password') }

  before do
    # Manually set the current_user for authentication
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #index' do
    it 'assigns @categories' do
      category = Category.create!(name: 'Category 1', icon: 'icon1.png', user:)
      get :index
      expect(assigns(:categories)).to eq([category])
    end
  end

  describe 'GET #show' do
    it 'assigns @category' do
      category = Category.create!(name: 'Category 1', icon: 'icon1.png', user:)
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new Category' do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new category' do
        expect do
          post :create, params: { category: { name: 'New Category', icon: 'new_icon.png', user: } }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to categories#index' do
        post :create, params: { category: { name: 'New Category', icon: 'new_icon.png', user: } }
        expect(response).to redirect_to(categories_path)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new category' do
        expect do
          post :create, params: { category: { name: nil, icon: 'new_icon.png', user: } }
        end.not_to change(Category, :count)
      end

      it 'renders the new template' do
        post :create, params: { category: { name: nil, icon: 'new_icon.png', user: } }
        expect(response).to render_template(:new)
      end
    end
  end
end
