class User < ApplicationRecord
    #validates
    # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    # validates :password, length: { minimum: 6 }, allow_nil: true
    #Associations
    has_one_attached :avatar
    has_many :tweets, dependent: :destroy
    has_many :like, dependent: :destroy
end
