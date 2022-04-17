class Prefecture < ApplicationRecord
  # has_many :profiles, dependent: :destroy

  def to_param
    slug
  end
  
end
