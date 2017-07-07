require 'minitest'
require 'diff_news'

class NewsServiceTest < Minitest::Test

  def test_mock_service_history
    DiffNews::Service::store_class = DiffNews::DefaultHistory
    service = DiffNews::Service.create 'mock_me'

    assert_equal 1, service.history.revisions.count
    assert_equal "Mock Teaser", service.history.revisions.first.teaser
    assert_equal "Mock Title", service.current_revision.title
  end

end
