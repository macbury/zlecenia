require 'test_helper'

class ToolsControllerTest < ActionController::TestCase
  def test_create_invalid
    Tool.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Tool.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    tool = Tool.first
    delete :destroy, :id => tool
    assert_redirected_to root_url
    assert !Tool.exists?(tool.id)
  end
end
