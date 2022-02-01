# frozen_string_literal: true

module PostsHelper
  def reduce_text(text)
    text.length <= 250 ? text : "#{text[0...250]} ... "
  end

  def like_element_tag(post, user)
    like = post.likes.find_by(user: user)
    content_tag(:div) do
      concat(content_tag(:span, post.likes_count, class: 'h4 me-2'))

      if like.present?
        concat(link_to(post_like_path(post, like), method: :delete) do
          content_tag(:i, nil, class: 'fas fa-thumbs-up fa-2x')
        end)
      else
        concat(link_to(post_likes_path(post), method: :post) do
          content_tag(:i, nil, class: 'far fa-thumbs-up fa-2x')
        end)
      end
    end
  end
end
