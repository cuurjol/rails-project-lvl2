# frozen_string_literal: true

class AddTitleCheckConstraintToPosts < ActiveRecord::Migration[6.1]
  def change
    add_check_constraint :posts, 'length(title) <= 120', name: 'title_check'
  end
end
