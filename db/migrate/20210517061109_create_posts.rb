class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :tag_id
      t.string :introduction_title
      t.string :introduction_text
      t.boolean :introduction?
      t.string :sum_action_step

      t.timestamps
    end
  end
end
