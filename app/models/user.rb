class User < ApplicationRecord
  before_create :default_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    #validates
    # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :name, presence: true
    # validates :password, length: { minimum: 6 }, allow_nil: true
    #Associations
    has_one_attached :avatar
    has_many :tweets, dependent: :destroy
    has_many :like, dependent: :destroy

    private
    def default_avatar
      return if avatar.attached?

      avatar.attach(io: File.open("app/assets/images/avatar.png"), filename: "default_avatar.png")
    end 
end
