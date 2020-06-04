class RemaneValidColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :valid, :status
  end
end
