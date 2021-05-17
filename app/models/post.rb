class Post < ApplicationRecord
  has_many :action_plans
  has_many :likes
  has_many :tag_hubs
  belongs_to :user
end
