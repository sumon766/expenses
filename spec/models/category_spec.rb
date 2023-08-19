# spec/models/category_spec.rb

require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:user) { User.create(name: 'John Doe', email: 'john@example.com', password: 'password') }

  it 'is valid with valid attributes' do
    category = Category.new(name: 'Groceries', icon: 'groceries_icon.png', user:)
    expect(category).to be_valid
  end

  it 'is not valid without a name' do
    category = Category.new(icon: 'groceries_icon.png', user:)
    expect(category).to_not be_valid
  end

  it 'is not valid without an icon' do
    category = Category.new(name: 'Groceries', user:)
    expect(category).to_not be_valid
  end

  it 'is not valid without a user' do
    category = Category.new(name: 'Groceries', icon: 'groceries_icon.png')
    expect(category).to_not be_valid
  end

  it 'belongs to a user' do
    category = Category.new(name: 'Groceries', icon: 'groceries_icon.png', user:)
    expect(category.user).to eq(user)
  end

  it 'associates expenses with a category' do
    category = Category.new(name: 'Test Category', icon: 'test_icon')

    expense1 = category.expenses.build(name: 'Item 1', amount: 20)
    expense2 = category.expenses.build(name: 'Item 2', amount: 30)

    category.save

    expect(category.expenses).to include(expense1, expense2)
  end
end
