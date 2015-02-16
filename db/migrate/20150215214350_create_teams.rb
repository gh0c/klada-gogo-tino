class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :conference
      t.string :link
      t.string :logo
      t.integer :position
      t.boolean :playoff

      t.timestamps null: false
    end
  end
end
