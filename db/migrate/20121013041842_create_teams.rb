class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |table|
      table.timestamps
      table.integer   :league_id,                                     :null => false
      table.string    :name,                          :limit => 128,  :null => true
      table.string    :logo_uid,     :default => nil,                 :null => true
      table.string    :logo_name,    :default => nil,                 :null => true
      table.integer   :team_size,    :default => 0,                   :null => false
      table.string    :slug,         :default => nil,  :null => false
    end

    add_index :teams, [ :league_id ]
    add_index :teams, :slug, :unique => true
  end
end
