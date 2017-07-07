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

  def test_tagi_history
    DiffNews::Service::store_class = DiffNews::DefaultHistory
    tagi = DiffNews::Service.create 'http://www.tagesanzeiger.ch/sport/tennis/aufschlag-smash-und-tschuess/story/10062709'
    assert_equal 1, tagi.history.revisions.count
  end

  def test_nzz_history
    DiffNews::Service::store_class = DiffNews::DefaultHistory
    nzz = DiffNews::Service.create 'https://www.nzz.ch/finanzen/abgang-eines-wichtigen-softwarespezialisten-die-tesla-aktie-hat-derzeit-gegenwind-ld.1304770'
    assert_equal 1, nzz.history.revisions.count
  end
end
