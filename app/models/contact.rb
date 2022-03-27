class Contact < ApplicationRecord
  belongs_to :user
  enum subject: %i[prompt work schedule music goods other]
end
