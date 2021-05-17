class RenameTagIdColumnToTags < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :tag_id, :tag
  end
end
