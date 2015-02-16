class AddScoreToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :wins, :integer, default: 0
    add_column :teams, :losses, :integer, default: 0
  end
end
