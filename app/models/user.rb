class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :relationships,class_name: "Relationship", foreign_key:"follower_id",dependent: :destroy
  has_many :reverse_of_relationships,class_name: "Relationship",foreign_key:"followed_id",dependent: :destroy
  has_many :followings,through: :relationships,source: :followed
  has_many :followers,through: :reverse_of_relationships,source: :follower
  has_many :comments, dependent: :destroy
  has_many :user_rooms
  has_many :chats
  has_many :rooms, through: :user_rooms

  has_one_attached :user_image

  def get_user_image(width,height)
   unless user_image.attached?
     file_path=Rails.root.join("app/assets/images/no_image.jpg")
     user_image.attach(io:File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg")
   end
     user_image.variant(resize_to_limit:[width,height]).processed
  end

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
end
