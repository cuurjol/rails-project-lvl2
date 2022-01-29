# frozen_string_literal: true

module PostsHelper
  def reduce_text(text)
    text.length <= 250 ? text : "#{text[0...250]} ... "
  end
end
