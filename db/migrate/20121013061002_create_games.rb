class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :league_id
      t.integer :home_id
      t.integer :away_id
      t.integer :home_score
      t.integer :away_score
      t.datetime :completed_at

      t.timestamps
    end
  end
end
