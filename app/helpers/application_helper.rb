# frozen_string_literal: true

module ApplicationHelper
  def password_hint(min_password_length)
    t('devise.shared.minimum_password_length', count: min_password_length) if min_password_length
  end
end
