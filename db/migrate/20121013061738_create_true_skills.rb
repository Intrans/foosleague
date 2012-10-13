class CreateTrueSkills < ActiveRecord::Migration
  def change
    create_table :true_skills do |t|

      t.integer :subject_id
      t.string :subject_type
      t.float :skill, :default => 750.0
      t.float :deviation, :default => 50
      t.float :activity, :default => 1.0

      t.timestamps
    end
  end
end
