require 'diff_news_base'

class DiffNewsTagesanzeiger < DiffNewsBase
  def initialize url
    super normalize_url(url)
  end
  
  def news_provider
    'tagesanzeiger.ch'
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
end