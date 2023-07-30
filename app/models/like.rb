class Like < ApplicationRecord
  validates_uniqueness_of :user_id, scope: :tweet_id
  belongs_to :user
  belongs_to :tweet, counter_cache: true
end
