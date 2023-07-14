require 'test/unit'
require_relative './show-recent-commig-msgs.rb'

class TestHook < Test::Unit::TestCase

  def test_split
    msgs = "a\nb\nc"
    splitted = msgs.split("\n")
  end

  def test_format_msgs
    msgs = "a\nb\nc"
    splitted = msgs.split("\n")
    formatted = format_msgs(3, splitted)
    assert_equal("\n# a\n# b\n# c", formatted)
  end
end
