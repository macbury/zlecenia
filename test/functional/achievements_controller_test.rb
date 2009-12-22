require 'test_helper'

class AchievementsControllerTest < ActionController::TestCase
  def test_create_invalid
    Achievement.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Achievement.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to root_url
  end
  
  def test_destroy
    achievement = Achievement.first
    delete :destroy, :id => achievement
    assert_redirected_to root_url
    assert !Achievement.exists?(achievement.id)
  end
end
