class AddAvatarAndIntroductionOnUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :introduction, :text
    add_column :users, :avatar, :string
  end
end
