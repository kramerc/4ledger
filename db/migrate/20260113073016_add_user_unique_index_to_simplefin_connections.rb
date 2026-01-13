class AddUserUniqueIndexToSimplefinConnections < ActiveRecord::Migration[8.1]
  def change
    remove_index :simplefin_connections, :user_id
    add_index :simplefin_connections, :user_id, unique: true
  end
end
