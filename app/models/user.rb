class User < ApplicationRecord
  before_create :default_avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable
    #validates
    # validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: true
    validates :username, presence: true, uniqueness: true
    # validates :password, length: { minimum: 6 }, allow_nil: true
    #Associations
    has_one_attached :avatar
    has_many :tweets, dependent: :destroy
    has_many :likes, dependent: :destroy

    #Enums for role
    enum :role, { member: 0, admin: 1}

    def self.from_omniauth(auth_hash)
      where(provider: auth_hash.provider, uid: auth_hash.uid).first_or_create do |user|
        user.provider = auth_hash.provider
        user.uid = auth_hash.uid
        user.username = auth_hash.info.nickname
        user.email = auth_hash.info.email
        user.password = Devise.friendly_token[0, 20]
      end
    end

    private
    def default_avatar
      return if avatar.attached?

      avatar.attach(io: File.open("app/assets/images/avatar.png"), filename: "default_avatar.png")
    end 
end
