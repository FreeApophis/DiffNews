require 'service'

module DiffNews

  class FAZ < Service
    def initialize url
      super url
    end
  
    def self.provider
      'faz.net'
    end

    def self.base_url
      'http://www.faz.net/aktuell/'
    end

    def self.valid_url
      /^https?:\/\/(www.)?faz.net/
    end

  private   
    def title
      normalize_text(strip_html(@doc.css("h2").first))
    rescue
      ''
    end
  
    def teaser
      'TODO'      
    rescue
      ''
    end
  
    def text
      normalize_text(strip_html(@doc.css(".FAZArtikelText").first))
    rescue
      ''
    end

    register_service
  end

end

