# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in(@user)
  end

  test 'should get index view' do
    get(posts_url)
    assert_response(:success)
  end

  test 'should get index view for unauthenticated user' do
    sign_out(@user)
    get(posts_url)
    assert_response(:success)
  end

  test 'should get new view' do
    get(new_post_url)
    assert_response(:success)
  end

  test 'should not get new view for unauthenticated user' do
    sign_out(@user)
    get(new_post_url)
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
  end

  test 'should create post' do
    post_params = { post: { title: 'Test title', body: 'Test body', post_category_id: post_categories(:health).id } }
    assert_difference('Post.count') { post(posts_url, params: post_params) }

    post = Post.last
    assert_response(:redirect)
    assert_redirected_to(post_url(post))
    assert { post.title == post_params[:post][:title] }
    assert { post.body == post_params[:post][:body] }
    assert { post.post_category_id == post_params[:post][:post_category_id] }
    assert { post.creator_id == @user.id }
  end

  test 'should not create post for unauthenticated user' do
    sign_out(@user)
    post_params = { post: { title: 'Test title', body: 'Test body', post_category_id: post_categories(:health).id } }
    assert_no_difference('Post.count') { post(posts_url, params: post_params) }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
  end

  test 'should show post view' do
    post = posts(:health)
    get(post_url(post))
    assert_response(:success)
  end

  test 'should show post view for unauthenticated user' do
    sign_out(@user)
    post = posts(:health)
    get(post_url(post))
    assert_response(:success)
  end

  test 'should destroy post' do
    post = posts(:health)
    assert_difference('Post.count', -1) { delete(post_url(post)) }
    assert_response(:redirect)
    assert_redirected_to posts_url
  end

  test 'should not destroy post for unauthenticated user' do
    sign_out(@user)
    post = posts(:health)
    assert_no_difference('Post.count') { delete(post_url(post)) }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
  end
end
