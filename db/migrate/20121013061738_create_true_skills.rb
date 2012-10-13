class CreateTrueSkills < ActiveRecord::Migration
  def change
    create_table :true_skills do |t|

      t.integer :player_id
      t.float :skill, :default => 750.0
      t.float :deviation, :default => 250
      t.float :activity, :default => 1.0

      t.timestamps
    end
  end
end
