require 'test_helper'

class ToolTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Tool.new.valid?
  end
end
