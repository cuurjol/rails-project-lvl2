# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :post_category
  belongs_to :creator, class_name: 'User', inverse_of: :posts

  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, presence: true, length: { maximum: 120 }
  validates :body, presence: true
end
