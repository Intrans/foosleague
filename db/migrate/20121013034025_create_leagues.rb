class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |table|
      table.timestamps
      table.string    :name,    :limit => 128,                   :null => false
      table.boolean   :doubles,                :default => true, :null => false
      table.string    :logo_uid,               :default => nil,  :null => true
      table.string    :logo_name,              :default => nil,  :null => true
      table.string    :slug,                   :default => nil,  :null => false
    end

    add_index :leagues, :slug, :unique => true
  end
end
