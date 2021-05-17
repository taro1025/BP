class CreateActionPlans < ActiveRecord::Migration[6.1]
  def change
    create_table :action_plans do |t|
      t.integer :action_id
      t.integer :post_id

      t.timestamps
    end
  end
end
