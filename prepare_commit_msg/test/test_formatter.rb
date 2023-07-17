require 'test/unit'
require_relative '../lib/recent_msg/formatter.rb'

class TestFormatter < Test::Unit::TestCase

  def test_format_msgs
    formatter = RecentMsg::Formatter.new()
    msgs = "a\nb\nc"
    splitted = msgs.split("\n")
    formatted = formatter.format_msgs(3, splitted)
    assert_equal("\n# a\n# b\n# c", formatted)
  end
end
