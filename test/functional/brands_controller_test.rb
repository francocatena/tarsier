require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  setup do
    sign_in Fabricate(:user)
  end
  
  test 'should get index' do
    2.times { Fabricate(:brand) { name { "Test #{sequence(:brand_name)}" } } }
    
    get :index, q: 'test', format: 'json'
    assert_response :success
    
    brands = ActiveSupport::JSON.decode(@response.body)
    
    assert_equal 2, brands.size
    assert brands.all? { |t| t['name'].match /test/i }
    
    get :index, q: 'no_brand', format: 'json'
    assert_response :success
    
    brands = ActiveSupport::JSON.decode(@response.body)
    
    assert_equal 0, brands.size
  end
end
