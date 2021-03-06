class Post < ApplicationRecord

  has_many :posts,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :favorited_users,through: :favorites,source: :user
  has_many :comments, dependent: :destroy

  has_one_attached :post_image

  def get_post_image(width,height)
   unless post_image.attached?
     file_path=Rails.root.join("app/assets/images/no_image.jpg")
     post_image.attach(io:File.open(file_path),filename: "default-image.jpg",content_type: "image/jpeg")
   end
     post_image.variant(resize_to_limit:[width,height]).processed
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  geocoded_by :address
  after_validation :geocode
end
