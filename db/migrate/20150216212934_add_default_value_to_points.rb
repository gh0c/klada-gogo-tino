class AddDefaultValueToPoints < ActiveRecord::Migration
  def up
    change_column :players, :points, :integer, :default => 0
  end
  
  def down
    change_column :players, :points, :integer, :default => nil
  end
end
