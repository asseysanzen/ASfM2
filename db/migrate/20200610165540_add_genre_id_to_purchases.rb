class AddGenreIdToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :genre_id, :integer
  end
end
