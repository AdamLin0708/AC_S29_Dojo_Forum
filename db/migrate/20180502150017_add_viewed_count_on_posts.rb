class AddViewedCountOnPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :viewed_count, :integer, :default => 0
  end
end
