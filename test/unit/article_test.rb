require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  def setup
    @article = Fabricate(:article)
  end
  
  test 'create' do
    assert_difference 'Article.count' do
      @article = Article.create(Fabricate.attributes_for(:article))
    end
  end
  
  test 'update' do
    assert_no_difference 'Article.count' do
      assert @article.update_attributes(name: 'Updated')
    end
    
    assert_equal 'Updated', @article.reload.name
  end
  
  test 'destroy' do
    assert_difference('Article.count', -1) { @article.destroy }
  end
  
  test 'validates blank attributes' do
    @article.name = ''
    @article.code = ''
    @article.price = nil
    
    assert @article.invalid?
    assert_equal 3, @article.errors.size
    assert_equal [error_message_from_model(@article, :name, :blank)],
      @article.errors[:name]
    assert_equal [error_message_from_model(@article, :code, :blank)],
      @article.errors[:code]
    assert_equal [error_message_from_model(@article, :price, :blank)],
      @article.errors[:price]
  end
  
  test 'validates well formated attributes' do
    @article.price = '2.x'
    
    assert @article.invalid?
    assert_equal 1, @article.errors.size
    assert_equal [error_message_from_model(@article, :price, :not_a_number)],
      @article.errors[:price]
  end
  
  test 'validates unique attributes' do
    new_article = Fabricate(:article)
    @article.code = new_article.code
    
    assert @article.invalid?
    assert_equal 1, @article.errors.size
    assert_equal [error_message_from_model(@article, :code, :taken)],
      @article.errors[:code]
  end
  
  test 'validates attributes boundaries' do
    @article.price = '0'
    
    assert @article.invalid?
    assert_equal 1, @article.errors.count
    assert_equal [
      error_message_from_model(@article, :price, :greater_than, count: 0)
    ], @article.errors[:price]
  end
  
  test 'validates length of _long_ attributes' do
    @article.name = 'abcde' * 52
    @article.code = 'abcde' * 52
    
    assert @article.invalid?
    assert_equal 2, @article.errors.count
    assert_equal [
      error_message_from_model(@article, :name, :too_long, count: 255)
    ], @article.errors[:name]
    assert_equal [
      error_message_from_model(@article, :code, :too_long, count: 255)
    ], @article.errors[:code]
  end
  
  test 'read tag list' do
    @article = Fabricate(:article) do
      tags!(count: 2) { |a, i| Fabricate(:tag, name: "Test #{i}") }
    end
    
    assert_equal 'Test 1,Test 2', @article.tag_list
  end
  
  test 'write tag list' do
    @article = Fabricate(:article) do
      tags!(count: 1) { |a, i| Fabricate(:tag, name: 'Test') }
    end
    
    assert_difference ['Tag.count', '@article.tags.count'], 2 do
      assert @article.update_attributes(
        tag_list: 'Test, Multi word tag,NewTag, '
      )
    end
    
    assert_equal 'Test,Multi word tag,NewTag', @article.reload.tag_list
    
    assert_difference '@article.tags.count', -2 do
      assert_no_difference 'Tag.count' do
        assert @article.update_attributes(tag_list: 'NewTag, ')
      end
    end
    
    assert_equal 'NewTag', @article.reload.tag_list
    
    assert_difference '@article.tags.count', -1 do
      assert_no_difference 'Tag.count' do
        assert @article.update_attributes(tag_list: '')
      end
    end
    
    assert_equal '', @article.reload.tag_list
  end
end
