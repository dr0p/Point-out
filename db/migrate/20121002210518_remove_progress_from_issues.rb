class RemoveProgressFromIssues < ActiveRecord::Migration
  def up
    remove_column :issues, :progress
  end

  def down
    add_column :issues, :progress, :text
  end
end
