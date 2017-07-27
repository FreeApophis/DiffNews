require 'service'

module DiffNews

  class NZZ < Service
    def initialize url
      super url
    end
  
    def self.provider
      'nzz.ch'
    end

    def self.base_url
      'https://www.nzz.ch/'
    end

    def self.valid_url
      /^https?:\/\/(www.)?nzz.ch/
    end

  private   
    def title
      normalize_text(strip_html(@doc.css(".title__name").first))
    rescue
      ''
    end
  
    def teaser
      normalize_text(strip_html(@doc.css(".leadtext").first))
    rescue
      ''
    end
  
    def text
      content = @doc.css("article.content").first
    
      content.css('script').remove
      content.css('.inlinePoll').remove
    
      normalize_text(strip_html(content))
    rescue
      ''
    end

    register_service
  end

end

