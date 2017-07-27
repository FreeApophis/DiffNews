require 'service'

module DiffNews

  class ZwanzigMinunten < Service
    def initialize url
      super url
    end
  
    def self.provider
      '20min.ch'
    end

    def self.base_url
      'http://www.20min.ch/'
    end

    def self.valid_url
      /^https?:\/\/(www.)?20min.ch/
    end

  private   
    def title
      normalize_text(strip_html(@doc.css("h1").first))
    rescue
      ''
    end
  
    def teaser
      normalize_text(strip_html(@doc.css("h3").first))
    rescue
      ''
    end
  
    def text
      normalize_text(strip_html(@doc.css(".story_text").first))
    rescue
      ''
    end

    register_service
  end

end

