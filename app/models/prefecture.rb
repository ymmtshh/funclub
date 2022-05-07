class Prefecture < ApplicationRecord
  has_many :profiles

  # validates :name, presence: true, uniqueness: { case_sensitive: false }
  
  def to_param
    slug
  end
  
end
