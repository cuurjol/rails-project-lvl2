# frozen_string_literal: true

class PostLike < ApplicationRecord
  belongs_to :post, counter_cache: :likes_count
  belongs_to :user

  validates :post_id, uniqueness: { scope: :user_id }
end
