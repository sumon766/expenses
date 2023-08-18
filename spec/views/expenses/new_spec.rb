require 'rails_helper'

RSpec.describe 'expenses/new', type: :view do
    let(:user) { instance_double(User, id: 1) } # Create a user double

    before do
      allow(view).to receive(:current_user).and_return(user) # Stub the current_user method
      assign(:expense, Expense.new)
      assign(:categories, [])
      render
    end
  
    it 'displays the "Create a new transaction" header' do
      expect(rendered).to have_content('Create a new transaction')
    end

  it 'displays the back link' do
    expect(rendered).to have_link(href: categories_path)
  end
end
