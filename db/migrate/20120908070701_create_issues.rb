class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.datetime :opened
      t.datetime :closed
      t.string :raised_by
      t.string :owner
      t.integer :priority
      t.text :progress
      t.string :status

      t.timestamps
    end
  end
end
