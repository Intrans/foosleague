class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |table|
      table.timestamps
      table.integer :league_id,                   :null => false
      table.string  :name,        :limit => 128,  :null => true
      table.integer :player_count, :default => 2, :null => false
    end

    add_index :teams, [ :league_id ]
  end
end
