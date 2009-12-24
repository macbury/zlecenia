require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  def test_create_invalid
    Contact.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Contact.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
end
