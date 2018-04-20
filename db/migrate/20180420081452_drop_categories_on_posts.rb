class DropCategoriesOnPosts < ActiveRecord::Migration[5.1]
  def change
    remove_column :posts, :categories
  end
end
