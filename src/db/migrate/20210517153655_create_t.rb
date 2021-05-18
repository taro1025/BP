class CreateT < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest
      t.string :image
      t.text :profile_text

      t.timestamps
    end
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.integer :tag_id
      t.string :introduction_title, default: 'はじめに'
      t.text :introduction_text
      t.boolean :introduction?, null: false, default: false
      t.integer :sum_action_step

      t.timestamps
    end
    create_table :tags do |t|
      t.string :tag, null: false

      t.timestamps
    end
    create_table :tag_hubs do |t|
      t.integer :tag_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
    create_table :action_plans do |t|
      t.integer :action_id, null: false
      t.integer :post_id, null: false

      t.timestamps
    end
  end
end
