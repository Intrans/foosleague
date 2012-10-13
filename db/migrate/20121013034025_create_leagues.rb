class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |table|
      table.timestamps
      table.string    :name,    :limit => 128,                   :null => false
      table.boolean   :doubles,                :default => true, :null => false
    end
  end
end
