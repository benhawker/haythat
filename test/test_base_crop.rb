require 'helper'

class ACrop < BaseCrop;end
class TestBaseCrop < Minitest::Test
  def test_init_child_class
    assert_includes(BaseCrop.children_class, ACrop)
  end
end
