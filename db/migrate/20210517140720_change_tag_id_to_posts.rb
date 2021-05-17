class ChangeTagIdToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :tag, :tag_id
  end
end
