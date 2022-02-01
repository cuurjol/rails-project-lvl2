# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      redirect_to(post, notice: 'Comment was successfully created.')
    else
      redirect_to(post, alert: 'Comment cannot be empty.')
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def comment_params
    params.require(:post_comment).permit(:content, :parent_id)
  end
end
