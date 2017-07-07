require 'minitest'
require 'diff_news'

class FileStoreTest < Minitest::Test

  def mock_service_file_history
    DiffNews::Service::store_class = DiffNews::FileHistory
    mock = DiffNews::Service.create 'mock_me'
  end

  def tagi_history
    DiffNews::Service::store_class = DiffNews::FileHistory
    tagi = DiffNews::Service.create 'http://www.tagesanzeiger.ch/sport/tennis/aufschlag-smash-und-tschuess/story/10062709'

    assert_equal 1, tagi.history.revisions.count
  end

end
