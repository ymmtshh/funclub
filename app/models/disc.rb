class Disc < ApplicationRecord
  belongs_to :user
  mount_uploader :image, DiscImageUploader
end
