class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |table|
      table.timestamps
      table.string    :name, :limit => 128, :null => false
    end
  end
end
