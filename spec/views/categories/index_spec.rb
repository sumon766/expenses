require 'rails_helper'

RSpec.describe 'categories/index', type: :view do
  before do
    user = User.create(name: 'John Doe', email: 'test@example.com', password: 'password')
    categories = [
      Category.create(name: 'Category 1', icon: 'icon1.png', user:, created_at: Time.now,
                      updated_at: Time.now),
      Category.create(name: 'Category 2', icon: 'icon2.png', user:, created_at: Time.now - 1.day,
                      updated_at: Time.now - 1.day)
    ]

    assign(:categories, categories)
    allow(view).to receive(:current_user).and_return(user)
    render template: 'categories/index'
  end

  context 'when user is logged in' do
    it 'displays "Add a new Category" link' do
      expect(rendered).to have_link('Add a new Category', href: new_category_path)
    end
  end

  context 'when user is not logged in' do
    before do
      allow(view).to receive(:current_user).and_return(nil)
      render template: 'categories/index'
    end

    it 'renders the shared/background partial' do
      expect(rendered).to render_template(partial: 'shared/_background')
    end
  end
end
