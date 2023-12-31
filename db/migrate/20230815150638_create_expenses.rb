class CreateExpenses < ActiveRecord::Migration[7.0]
  def change
    create_table :expenses do |t|
      t.string :name
      t.decimal :amount
      t.references :user, null: false, foreign_key: true, on_delete: :cascade
      t.references :category, null: false, foreign_key: true, on_delete: :cascade
      t.timestamps
    end
  end
end
