class Good < ApplicationRecord
  belongs_to :user
  mount_uploader :image, GoodImageUploader
end
