class CreateTagHubs < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_hubs do |t|
      t.string :tag

      t.timestamps
    end
  end
end
