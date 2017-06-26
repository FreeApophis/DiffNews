require 'minitest'

class ExampleTest < Minitest::Test
  def test_command
    test = 'test'

    assert_equal 'test', test
  end
end
