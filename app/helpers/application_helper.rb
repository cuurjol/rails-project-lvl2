# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def password_hint(min_password_length)
    t('devise.shared.minimum_password_length', count: min_password_length) if min_password_length
  end

  def markdown(text)
    options = %i[
      hard_wrap autolink no_intra_emphasis tables fenced_code_blocks
      disable_indented_code_blocks strikethrough lax_spacing space_after_headers
      quote footnotes highlight underline
    ]

    Markdown.new(text, *options).to_html
  end
end
