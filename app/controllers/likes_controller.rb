# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    if post.likes.create(user: current_user)
      redirect_to(post, notice: t('.success'))
    else
      redirect_to(post, alert: t('.failure'))
    end
  end

  def destroy
    if already_liked?
      post.likes.find(params[:id]).destroy
      redirect_to(post, notice: t('.success'))
    else
      redirect_to(post, alert: t('.failure'))
    end
  end

  private

  def post
    @post ||= Post.find(params[:post_id])
  end

  def already_liked?
    PostLike.exists?(user: current_user, post: post)
  end
end
