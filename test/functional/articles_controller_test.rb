require 'test_helper'

class ArticlesControllerTest < ActionController::TestCase
  setup do
    @article = Fabricate(:article)
    
    sign_in Fabricate(:user)
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:articles)
    assert_select '#unexpected_error', false
    assert_template 'articles/index'
  end

  test 'should get new' do
    get :new
    assert_response :success
    assert_not_nil assigns(:article)
    assert_select '#unexpected_error', false
    assert_template 'articles/new'
  end

  test 'should create article' do
    assert_difference('Article.count') do
      post :create, article: Fabricate.attributes_for(:article)
    end

    assert_redirected_to article_path(assigns(:article))
  end

  test 'should show article' do
    get :show, id: @article
    assert_response :success
    assert_not_nil assigns(:article)
    assert_select '#unexpected_error', false
    assert_template 'articles/show'
  end

  test 'should get edit' do
    get :edit, id: @article
    assert_response :success
    assert_not_nil assigns(:article)
    assert_select '#unexpected_error', false
    assert_template 'articles/edit'
  end

  test 'should update article' do
    assert_no_difference 'Article.count' do
      put :update, id: @article,
        article: Fabricate.attributes_for(:article, name: 'Upd')
    end
    
    puts assigns(:article).errors.full_messages.join("\n")
    
    assert_redirected_to article_path(assigns(:article))
    assert_equal 'Upd', @article.reload.name
  end

  test 'should destroy article' do
    assert_difference('Article.count', -1) do
      delete :destroy, id: @article
    end

    assert_redirected_to articles_path
  end
end
