class AddDefaultValueAtActivated < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :activated, :boolean, default: false
  end
end
