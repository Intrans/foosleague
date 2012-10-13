class CreateGameLogs < ActiveRecord::Migration
  def change
    create_table :game_logs do |t|
      t.integer :game_id
      t.integer :team_id
      t.string :type

      t.timestamps
    end
  end
end
