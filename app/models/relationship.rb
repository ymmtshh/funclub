class Relationship < ApplicationRecord
    belongs_to :following ,class_name: "User"
    belongs_to :follower, class_name: "User"

    validates :following_id, presence: true
    validates :follower_id, presence: true

    has_many :notifications, as: :event

    # def notification_create_message
    #     "新しくフォローがされました"
    # end

    # def notification_edit_message(edit_user)
    # "#{edit_user}によりフォローが変更されました"
    # end
    
    # def notification_params_hash
    #     hash = {}
    #     hash[:path_model] = self.user
    #     hash
    # end
end
