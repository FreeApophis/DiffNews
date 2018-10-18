require 'service'

module DiffNews

  class Watson < Service
    def initialize url
      super url
    end
  
    def self.provider
      'watson.ch'
    end

    def self.base_url
      'https://www.watson.ch/'
    end

    def self.valid_url
      /^https?:\/\/(www.)?watson.ch/
    end

  private   
    def title
      normalize_text(strip_html(@doc.css("h2").first))
    rescue
      ''
    end
  
    def teaser
      normalize_text(strip_html(@doc.css("h1").first))
    rescue
      ''
    end
  
    def text
      normalize_text(strip_html(@doc.css(".story").first))
    rescue
      ''
    end

    register_service
  end

end
