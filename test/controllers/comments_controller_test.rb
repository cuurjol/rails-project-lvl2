# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @post = posts(:health)
    @user = users(:one)
    sign_in(@user)
  end

  test 'should create comment' do
    params = { post_comment: { content: Faker::Lorem.paragraph, parent_id: nil } }
    assert_difference('PostComment.count') { post(post_comments_url(@post), params: params) }

    needed_attributes = { content: params[:post_comment][:content], post: @post, user: @user, ancestry: nil }
    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { PostComment.exists?(needed_attributes) }
  end

  test 'should not create comment for unauthenticated user' do
    sign_out(@user)
    params = { post_comment: { content: Faker::Lorem.paragraph, parent_id: nil } }
    assert_no_difference('PostComment.count') { post(post_comments_url(@post), params: params) }

    needed_attributes = { content: params[:post_comment][:content], post: @post, user: @user, ancestry: nil }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { !PostComment.exists?(needed_attributes) }
  end

  test 'should create child comment for existing comment' do
    root_comment = post_comments(:root_comment)
    params = { post_comment: { content: Faker::Lorem.paragraph, parent_id: root_comment.id } }
    assert_difference('PostComment.count') { post(post_comments_url(@post), params: params) }

    needed_attributes = { content: params[:post_comment][:content], post: @post, user: @user, ancestry: root_comment }
    assert_response(:redirect)
    assert_redirected_to(post_url(@post))
    assert { PostComment.exists?(needed_attributes) }
  end

  test 'should not create child comment for unauthenticated user' do
    sign_out(@user)
    root_comment = post_comments(:root_comment)
    params = { post_comment: { content: Faker::Lorem.paragraph, parent_id: root_comment.id } }
    assert_no_difference('PostComment.count') { post(post_comments_url(@post), params: params) }

    needed_attributes = { content: params[:post_comment][:content], post: @post, user: @user, ancestry: root_comment }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { !PostComment.exists?(needed_attributes) }
  end
end
