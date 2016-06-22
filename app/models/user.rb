class User < ActiveRecord::Base
  has_many :works
  has_many :performances
  has_one :profile
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships #, source: :follower
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def follow(user_to_follow)
    active_relationships.create(followed_id: user_to_follow.id)
  end
  
  def unfollow(user_to_unfollow)
    active_relationsihps.find_by(followed_id: user_to_unfollow.id).destroy
  end
  
  def following?(some_user)
    following.include?(some_user)
  end
end
