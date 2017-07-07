require 'service'
require 'revision'

module DiffNews

  class Tagesanzeiger < Service
    def initialize url
      super normalize_url(url)
    end

    def self.provider
      'tagesanzeiger.ch'
    end

    def self.valid_url
      /^https?:\/\/(www.)?tagesanzeiger.ch/
    end

private

  # Remove the SEO parts, making the URL more unique
    def normalize_url url
      parts = url.split('/')
      if parts.count > 5
        (parts.first(4) + parts.last(2)).join('/')
      else
        url
      end
    end

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
      content = @doc.css("#mainContent").first
    
      content.css('script').remove
      content.css('.inlinePoll').remove
    
      normalize_text(strip_html(content))
    rescue
      ''
    end

    register_service
  end
end
