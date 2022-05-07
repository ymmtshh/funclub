class ProfileGenre < ApplicationRecord
  belongs_to :profile
  belongs_to :genre

  validates :profile_id, presence: true
  validates :genre_id, presence: true
end
