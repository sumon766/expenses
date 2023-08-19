require 'rails_helper'

RSpec.describe 'categories/show', type: :view do
  let(:category) { Category.create(name: 'Category 1', icon: 'icon1.png') }

  context 'when there are expenses' do
    let(:expenses) do
      [
        Expense.create(name: 'Expense 1', amount: 100, category:, created_at: Time.now),
        Expense.create(name: 'Expense 2', amount: 150, category:, created_at: Time.now - 1.day)
      ]
    end

    before do
      assign(:category, category)
      assign(:expenses, expenses)
      render
    end

    it 'displays category name and icon' do
      expect(rendered).to have_content(category.name)
      expect(rendered).to have_css("img[src*='#{category.icon}']")
    end

    it 'displays each expense' do
      expenses.each do |expense|
        expect(rendered).to have_content(expense.name)
        expect(rendered).to have_content(expense.created_at.strftime('%d %b %Y'))
        expect(rendered).to have_content(expense.amount)
      end
    end

    it 'displays the "Scan" button' do
      expect(rendered).to have_link('Scan', href: new_expense_path)
    end
  end

  context 'when there are no expenses' do
    before do
      assign(:category, category)
      assign(:expenses, []) # Assign an empty array for no expenses
      render
    end

    it 'displays category name and icon' do
      expect(rendered).to have_content(category.name)
      expect(rendered).to have_css("img[src*='#{category.icon}']")
    end

    it 'displays a message for no transactions' do
      expect(rendered).to have_content("You don't have transactions here yet.")
    end

    it 'displays the "Scan" button' do
      expect(rendered).to have_link('Scan', href: new_expense_path)
    end
  end
end
