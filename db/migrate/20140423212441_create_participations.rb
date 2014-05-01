class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.references :team, index: true
      t.references :group, index: true
      t.integer :points
      t.integer :games
      t.integer :wins
      t.integer :draws
      t.integer :losses
      t.integer :goals_scored
      t.integer :goals_against

      t.timestamps
    end
  end
end
