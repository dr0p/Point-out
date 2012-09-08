class Issue < ActiveRecord::Base
  attr_accessible :closed, :description, :opened, :owner, :priority, :progress, :raised_by, :status, :title, :user_id
  validates :description, :presence => true
  validates :title, :presence => true
end
