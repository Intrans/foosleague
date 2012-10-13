class AddColumnsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :provider, :string
    add_column :players, :uid, :string
    add_column :players, :name, :string
    add_column :players, :twitter_name, :string
    
    add_index :players, :twitter_name, :unique => true
  end
end
