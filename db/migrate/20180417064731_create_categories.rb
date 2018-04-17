class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :code_abbr
      t.string :name
      t.timestamps
    end
  end
end
