require 'minitest'
require 'diff_news'

class FileStoreTest < Minitest::Test

  def mock_service_file_history
    DiffNews::Service::store_class = DiffNews::FileHistory
    mock = DiffNews::Service.create 'mock_me'
  end

end
