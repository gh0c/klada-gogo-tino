class CreatePredictions < ActiveRecord::Migration
  def change
    create_table :predictions do |t|
      t.integer :position
      t.boolean :playoff
      t.integer :wins
      t.integer :losses
      t.references :player, index: true
      t.references :team, index: true

      t.timestamps null: false
    end
    add_foreign_key :predictions, :players
    add_foreign_key :predictions, :teams
  end
end
