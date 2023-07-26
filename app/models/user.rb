class User < ApplicationRecord
    has_one_attached :avatar
    has_many :tweets, dependent: :destroy
    has_many :like, dependent: :destroy
end
