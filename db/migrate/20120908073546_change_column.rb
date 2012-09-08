class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :issues, :opened, :date
    change_column :issues, :closed, :date
  end

  def down
    change_column :issues, :opened, :datetime
    change_column :issues, :closed, :datetime
  end
end
