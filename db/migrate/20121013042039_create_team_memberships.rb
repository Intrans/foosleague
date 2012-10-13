class CreateTeamMemberships < ActiveRecord::Migration
  def change
    create_table :team_memberships do |table|
      table.timestamps
      table.integer     :player_id, :null => false
      table.integer     :team_id,   :null => false
    end

    add_index :team_memberships, [ :team_id ]
    add_index :team_memberships, [ :team_id, :player_id ], :unique => true
    add_index :team_memberships, [ :player_id ]
  end
end
