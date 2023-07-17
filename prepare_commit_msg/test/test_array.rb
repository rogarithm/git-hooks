require 'test/unit'

class TestArray < Test::Unit::TestCase

  def test_split
    msgs = "a\nb\nc"
    assert_equal(true, msgs.split("\n").kind_of?(Array))
  end
end
