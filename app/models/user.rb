class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :active_relationships, class_name: "Relationships", foreign_key: :follower_id, dependent: :destroy
	#you following somebody
	has_many :passive_relationships, class_name: "Relationships", foreign_key: :followed_id, dependent: :destroy
	#somebody following you
	has_many :following, through: :active_relationships, source: :followed
	has_many :followers, through: :passive_relationships, source: :follower
	validates :email, presence: true
end