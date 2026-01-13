class AddRefreshedAtToSimplefinConnections < ActiveRecord::Migration[8.1]
  def change
    add_column :simplefin_connections, :refreshed_at, :timestamp
    add_index :simplefin_connections, :refreshed_at
  end
end
