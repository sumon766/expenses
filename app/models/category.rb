class Category < ApplicationRecord
  validates :name, :icon, presence: true
  belongs_to :user
  has_many :expenses, dependent: :delete_all
end
