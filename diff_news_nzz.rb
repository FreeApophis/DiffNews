require 'diff_news_base'

class DiffNewsNzz < DiffNewsBase
  def initialize url
    super
  end
  
  def news_provider
    'nzz.ch'
  end
   
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
end