class AddDeadlineToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :deadline, :date
  end
end
