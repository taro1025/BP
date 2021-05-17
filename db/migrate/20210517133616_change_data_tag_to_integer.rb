class ChangeDataTagToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :tags, :tag, :integer
  end
end
