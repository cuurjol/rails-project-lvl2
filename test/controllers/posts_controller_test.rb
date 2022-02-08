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
    title = Faker::Lorem.sentence
    body = Faker::Lorem.paragraph
    params = { post: { title: title, body: body, post_category_id: post_categories(:health).id } }
    assert_difference('Post.count') { post(posts_url, params: params) }

    assert_response(:redirect)
    assert_redirected_to(post_url(Post.last))
    assert { Post.exists?(params[:post].merge(creator: @user)) }
  end

  test 'should not create post for unauthenticated user' do
    title = Faker::Lorem.sentence
    body = Faker::Lorem.paragraph
    params = { post: { title: title, body: body, post_category_id: post_categories(:health).id } }

    sign_out(@user)
    assert_no_difference('Post.count') { post(posts_url, params: params) }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { !Post.exists?(params[:post]) }
  end

  test 'should show post view' do
    get(post_url(posts(:health)))
    assert_response(:success)
  end

  test 'should show post view for unauthenticated user' do
    sign_out(@user)
    get(post_url(posts(:health)))
    assert_response(:success)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) { delete(post_url(posts(:health))) }
    assert_response(:redirect)
    assert_redirected_to(posts_url)
    assert { !Post.exists?(posts(:health).id) }
  end

  test 'should not destroy a foreign post' do
    assert_no_difference('Post.count') { delete(post_url(posts(:travel))) }
    assert_response(:redirect)
    assert_redirected_to(posts_url)
    assert { Post.exists?(posts(:travel).id) }
  end

  test 'should not destroy post for unauthenticated user' do
    sign_out(@user)
    assert_no_difference('Post.count') { delete(post_url(posts(:health))) }
    assert_response(:redirect)
    assert_redirected_to(new_user_session_url)
    assert { Post.exists?(posts(:health).id) }
  end
end
