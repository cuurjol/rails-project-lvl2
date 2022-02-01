# frozen_string_literal: true

class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post, counter_cache: :comments_count
  has_ancestry

  validates :content, presence: true
end
