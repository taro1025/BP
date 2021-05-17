class ChangeSomething < ActiveRecord::Migration[6.1]
  def change
    add_column :tag_hubs, :tag_id, :integer
    add_column :tag_hubs, :post_id, :integer
    remove_column :tag_hubs, :tag, :string
    change_column :tags, :tag, :string
    remove_column :tags, :post_id, :integer
    #以下、stringをtextに。
    change_column :users, :profile_text, :text
    change_column :posts, :introduction_text, :text
    change_column :actions, :description, :text
  end
end
