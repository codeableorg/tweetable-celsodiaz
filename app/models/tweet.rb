class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :replied_to, class_name: "Tweet", optional: true, counter_cache: :replies_count
  has_many :like, dependent: :destroy
end
