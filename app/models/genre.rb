class Genre < ApplicationRecord
  has_many :profile_genres, dependent: :destroy
  has_many :profiles, through: :profile_genres, dependent: :destroy

  # validates :name, presence: true, uniqueness: { case_sensitive: false }

  def to_param
    slug
  end
  
end
