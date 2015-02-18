class AddNickToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :nickname, :string
  end
end
