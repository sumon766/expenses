require 'rails_helper'

RSpec.describe Expense, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      category = Category.create(name: 'Test Category', icon: 'test.png', user:)
      expense = Expense.new(name: 'Test Expense', amount: 100, user:, category:)

      expect(expense).to be_valid
    end

    it 'is not valid without a name' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      category = Category.create(name: 'Test Category', icon: 'test.png', user:)
      expense = Expense.new(amount: 100, user:, category:)

      expect(expense).not_to be_valid
      expect(expense.errors[:name]).to include("can't be blank")
    end

    it 'is not valid without an amount' do
      user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
      category = Category.create(name: 'Test Category', icon: 'test.png', user:)
      expense = Expense.new(name: 'Test Expense', user:, category:)

      expect(expense).not_to be_valid
      expect(expense.errors[:amount]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'should belong to a user' do
      expense = Expense.create(name: 'Food', amount: 100, user_id: 1)
      assert expense.user_id == 1
    end

    it 'should belong to a category' do
      expense = Expense.create(name: 'Food', amount: 100, category_id: 1)
      assert expense.category_id == 1
    end
  end
end
