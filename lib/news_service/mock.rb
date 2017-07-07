#
# Mock Service Implementation
#

require 'service'

module DiffNews

  class MockService < Service
    attr_reader :title, :teaser, :text

    def initialize url
      @title = "Mock Title"
      @teaser = "Mock Teaser"
      @text = "Mock Text"

      super url
    end

    def self.provider
      'mock_service'
    end

    def self.valid_url
      /mock_me/
    end
   
    def load_document
    end

    register_service
  end

end

