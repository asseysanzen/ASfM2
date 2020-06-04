class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|

      t.integer :user_id
      t.integer :genre_id
      t.string :item_name
      t.text :description
      t.integer :price
      t.string :image_id
      t.integer :status, default:0, null:false, limit:1

      t.timestamps
    end
  end
end
