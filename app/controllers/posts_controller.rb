# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  def index
    @pagy, @posts = pagy(Post.includes(:creator))
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to(@post, notice: t('.success'))
    else
      render(:new)
    end
  end

  def show
    @post = find_post
    @comments = @post.comments.includes(:user).arrange
  end

  def destroy
    @post = find_post

    if @post.creator == current_user
      @post.destroy
      redirect_to(posts_url, notice: t('.success'))
    else
      redirect_to(posts_url, alert: t('.failure'))
    end
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id)
  end
end
