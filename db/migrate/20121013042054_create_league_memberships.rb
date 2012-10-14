class CreateLeagueMemberships < ActiveRecord::Migration
  def change
    create_table :league_memberships do |table|
      table.timestamps
      table.integer     :player_id,                    :null => false
      table.integer     :league_id,                    :null => false
      table.boolean     :admin,     :default => false, :null => false
      table.integer     :starting_skill, :default => 250, :null => false
    end

    add_index :league_memberships, [ :league_id ]
    add_index :league_memberships, [ :league_id, :player_id ], :unique => true
    add_index :league_memberships, [ :player_id ]

  end
end
