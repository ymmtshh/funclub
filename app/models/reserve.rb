class Reserve < ApplicationRecord

  #    status: {承認待ち: 0, 承認: 1, 不承認: 2}
  enum status: {Waiting: 0, Approved: 1, Declined: 2}

  belongs_to :user
  belongs_to :schedule

end
