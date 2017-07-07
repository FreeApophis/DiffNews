#
# Diff News
#

$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__))) unless $LOAD_PATH.include?(File.expand_path(File.dirname(__FILE__)))

require 'service'
require 'default_history'
require 'file_history'
require 'news_service/mock'
require 'news_service/20min'
require 'news_service/faz'
require 'news_service/tagesanzeiger'
require 'news_service/nzz'
