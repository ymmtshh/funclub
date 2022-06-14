class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  mount_uploader :image, PostImageUploader

  def liked_by?(user)
    likes.where(user_id: user).exists?
  end

end
