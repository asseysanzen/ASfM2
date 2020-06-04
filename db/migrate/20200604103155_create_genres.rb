class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

      t.string :kind
      t.integer :status, default:0, null:false, limit:1

      t.timestamps
    end
  end
end
