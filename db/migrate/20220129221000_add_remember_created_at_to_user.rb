# frozen_string_literal: true

class AddRememberCreatedAtToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :remember_created_at, :datetime
  end
end
