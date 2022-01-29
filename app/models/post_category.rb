# frozen_string_literal: true

class PostCategory < ApplicationRecord
  has_many :posts, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
