class Disc < ApplicationRecord
  belongs_to :user
  belongs_to :disc_category
  mount_uploader :image, DiscImageUploader
end
