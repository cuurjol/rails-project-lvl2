# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to(@post, notice: 'Post was successfully created.')
    else
      render(:new)
    end
  end

  def show
    @post = find_post
  end

  def destroy
    @post = find_post
    @post.destroy
    redirect_to(posts_url, notice: 'Post was successfully destroyed.')
  end

  private

  def find_post
    Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :post_category_id, :creator_id)
  end
end
