class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.timestamps
      t.integer :league_id
      t.integer :home_id
      t.integer :away_id
      t.integer :home_score, :default => 0, :null => false
      t.integer :away_score, :default => 0, :null => false
    end
  end
end
