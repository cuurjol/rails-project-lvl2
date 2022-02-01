# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :validatable, :rememberable

  has_many :post_comments, dependent: :destroy
  has_many :posts, class_name: 'Post', foreign_key: :creator_id, inverse_of: :creator, dependent: :destroy
  has_many :likes, dependent: :destroy
end
