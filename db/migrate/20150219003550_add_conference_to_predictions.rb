class AddConferenceToPredictions < ActiveRecord::Migration
  def change
    add_column :predictions, :conference, :string
  end
end
