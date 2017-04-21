class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :users, :through => :like
  validates :content, :user_id, presence: true

end
