# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :creator, class_name: 'User', inverse_of: :posts

  validates :title, presence: true, length: { maximum: 120 }
  validates :body, presence: true
end
