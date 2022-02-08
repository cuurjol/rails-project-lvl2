# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:health)
    @user = users(:one)
    sign_in(@user)
  end

  test 'should create like' do
    assert_difference('PostLike.count') { post(post_likes_url(@post)) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { PostLike.exists?(post: @post, user: @user) }
  end

  test 'should not create like more than twice' do
    @post.likes.create(user: @user)
    assert_no_difference('PostLike.count') { post(post_likes_url(@post)) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { @post.likes_count == 1 }
  end

  test 'should not create like for unauthenticated user' do
    sign_out(@user)
    assert_no_difference('PostLike.count') { post(post_likes_url(@post)) }

    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { @post.likes_count.zero? }
  end

  test 'should destroy like' do
    like = @post.likes.create(user: @user)
    assert_difference('PostLike.count', -1) { delete(post_like_url(@post, like)) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { !PostLike.exists?(like.id) }
  end

  test 'should not destroy like mark for unliked post' do
    sign_out(@user)
    sign_in(users(:two))

    like = @post.likes.create(user: @user)
    assert_no_difference('PostLike.count', -1) { delete(post_like_url(@post, like)) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { PostLike.exists?(like.id) }
  end

  test 'should not destroy like for unauthenticated user' do
    sign_out(@user)

    like = @post.likes.create(user: @user)
    assert_no_difference('PostLike.count', -1) { delete(post_like_url(@post, like)) }

    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { PostLike.exists?(like.id) }
  end
end
