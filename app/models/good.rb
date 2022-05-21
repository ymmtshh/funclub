class Good < ApplicationRecord
  belongs_to :user
  belongs_to :goods_category
  mount_uploader :image, GoodImageUploader
end