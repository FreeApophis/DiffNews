class DiffNewsGrabber
  def initialize base
    @url = base
  end
  
  def links
    parse 
    links = @doc.xpath('//a[@href]').map{ |link| link["href"].strip }
    links = links.select{ |link| filter_link(link) }.map{ |link| full_url(link, @url) }
    links.uniq.sort
  end

private
  def parse
    @doc = Nokogiri::HTML(open(@url))
  end
  
  def filter_link link
    return false if link.start_with?('javascript')
    true
  end
  
  def full_url rel, url
    return rel if rel.match /^[\w]*:\/\//
    uri = URI(url)
    if rel[0] == '/'
      "#{uri.scheme}://#{uri.host}#{rel}"
    else
      path = uri.path.split('/')[0..-2].select{|m| !m.empty?}.join('/')
      "#{uri.scheme}://#{uri.host}/#{path}/#{rel}"
    end
  end
end