#
# Store and retrieve a history by provider and uuid
#

require 'revision'
require 'yaml'

module DiffNews

  class FileHistory < DefaultHistory
    attr_reader :revisions

    def initialize provider, uuid, url
      super provider, uuid, url
    end

    def file_path(extension)
       "#{@provider}/#{@uuid}.#{extension}"
    end
  
    def load
      if File.exist? file_path('yml')
        @revisions = YAML.load(File.open(file_path('yml'), 'r:UTF-8', &:read))
      end
    end

    def store
      if @revisions
        File.open(file_path('yml'), 'w:UTF-8') do |file|
          file.write(YAML::dump(@revisions))
        end
      end
    end
  end

end
