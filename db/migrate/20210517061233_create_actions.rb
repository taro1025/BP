class CreateActions < ActiveRecord::Migration[6.1]
  def change
    create_table :actions do |t|
      t.integer :step
      t.string :conclusion
      t.string :description

      t.timestamps
    end
  end
end
