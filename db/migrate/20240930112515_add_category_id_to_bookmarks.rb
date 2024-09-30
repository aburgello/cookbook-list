class AddCategoryIdToBookmarks < ActiveRecord::Migration[7.2]
  def change
    add_column :bookmarks, :category_id, :bigint
  end
end