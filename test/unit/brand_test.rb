require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  def setup
    @brand = Fabricate(:brand)
  end
  
  test 'create' do
    assert_difference 'Brand.count' do
      @brand = Brand.create(Fabricate.attributes_for(:brand))
    end
  end
  
  test 'update' do
    assert_no_difference 'Brand.count' do
      assert @brand.update_attributes(name: 'Updated')
    end
    
    assert_equal 'Updated', @brand.reload.name
  end
  
  test 'destroy' do
    assert_difference('Brand.count', -1) { @brand.destroy }
  end
  
  test 'validates blank attributes' do
    @brand.name = ''
    
    assert @brand.invalid?
    assert_equal 1, @brand.errors.size
    assert_equal [error_message_from_model(@brand, :name, :blank)],
      @brand.errors[:name]
  end
  
  test 'validates unique attributes' do
    new_brand = Fabricate(:brand)
    @brand.name = new_brand.name.upcase
    
    assert @brand.invalid?
    assert_equal 1, @brand.errors.size
    assert_equal [error_message_from_model(@brand, :name, :taken)],
      @brand.errors[:name]
  end
  
  test 'validates length of _long_ attributes' do
    @brand.name = 'abcde' * 52
    
    assert @brand.invalid?
    assert_equal 1, @brand.errors.count
    assert_equal [
      error_message_from_model(@brand, :name, :too_long, count: 255)
    ], @brand.errors[:name]
  end
end
