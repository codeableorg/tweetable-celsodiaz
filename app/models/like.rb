class Like < ApplicationRecord
  validates :user_id, uniqueness: { scope: :tweet_id }
  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
