class Bookmark < ApplicationRecord
  belongs_to :recipe
  belongs_to :category

  validates :recipe_id, presence: true
  validates :category_id, presence: true
  validates :comment, length: { minimum: 6 }
  validates :recipe, uniqueness: { scope: :category }
end
