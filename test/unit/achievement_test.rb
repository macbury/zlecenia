require 'test_helper'

class AchievementTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Achievement.new.valid?
  end
end
