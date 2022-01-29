# frozen_string_literal: true

post_categories = %w[Health Nature Education Science Travel]
post_categories.each { |category| PostCategory.create(name: category) }
