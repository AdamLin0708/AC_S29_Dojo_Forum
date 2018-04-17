class AddColumnsInPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :title, :string
    add_column :posts, :user_id, :integer
    add_column :posts, :image, :string  
    add_column :posts, :categories, :text
  end
end
