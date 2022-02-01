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
    comment_params = { post_comment: { content: 'Test comment content', parent_id: nil } }
    assert_difference('PostComment.count') { post(post_comments_url(@post), params: comment_params) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))

    comment = PostComment.last
    assert { comment.content == comment_params[:post_comment][:content] }
    assert { comment.post == @post }
    assert { comment.user == @user }
    assert { comment.parent_id.nil? }
  end

  test 'should not create comment for unauthenticated user' do
    sign_out(@user)
    comment_params = { post_comment: { content: 'Test comment content', parent_id: nil } }
    assert_no_difference('PostComment.count') { post(post_comments_url(@post), params: comment_params) }

    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
  end

  test 'should create child comment for existing comment' do
    root_comment = post_comments(:root_comment)
    comment_params = { post_comment: { content: 'Test child comment content', parent_id: root_comment.id } }
    assert_difference('PostComment.count') { post(post_comments_url(@post), params: comment_params) }

    assert_response(:redirect)
    assert_redirected_to(post_url(@post))

    comment = PostComment.last
    assert { comment.content == comment_params[:post_comment][:content] }
    assert { comment.post == @post }
    assert { comment.user == @user }
    assert { comment.parent_id == root_comment.id }
  end

  test 'should not create child comment for unauthenticated user' do
    sign_out(@user)
    root_comment = post_comments(:root_comment)
    comment_params = { post_comment: { content: 'Test child comment content', parent_id: root_comment.id } }
    assert_no_difference('PostComment.count') { post(post_comments_url(@post), params: comment_params) }

    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
  end
end
