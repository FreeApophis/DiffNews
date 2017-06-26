require 'nokogiri'
require 'open-uri'
require 'uuidtools'
require 'news_object'
require 'diff_news_diff'

class DiffNewsBase
  attr_reader :url, :uuid

  def initialize url
    puts url
    @url = url
    @uuid =  UUIDTools::UUID.sha1_create(UUIDTools::UUID_URL_NAMESPACE, url)
    load_history
    parse
    update_history
  end

  def title; raise 'Not Implemented Exception'; end
  def teaser; raise 'Not Implemented Exception'; end
  def text; raise 'Not Implemented Exception'; end

private
  def parse
    @doc = Nokogiri::HTML(open(url))
  end

  def strip_html partial
    partial.css("br").each { |node| node.replace("\n") }
    partial.css("p").each { |node| node.replace("#{node.text.strip}\n\n") }
    partial.text.strip
  end

  def normalize_text text
    empty_lines = 0
    result = ''
    text.each_line do |line|
      line = line.strip
      line = line.gsub(/\s+/, ' ')
      empty_lines = line.length == 0 ? empty_lines + 1 : 0
      if empty_lines < 2
        result += line.strip + "\n"
      end
    end
    return result
  end

  def file_path(extension)
    "#{news_provider}/#{uuid}.rev-#{@revision}.#{extension}"
  end

  def load_history
    @revision = 0
    @history = []

    while true
      if File.exists?(file_path('json'))
        @history << NewsObject.new
        @history.last.load file_path('json')
      else
        return
      end
      @revision += 1
    end
  end

  def update_history
    if changed?
      puts "Article has changed or is new"
      n = NewsObject.new

      n.title = title
      n.teaser = teaser
      n.text = text

      n.save file_path('json')

      @history << n
      diff = DiffNewsDiff.new @history.last(2)
      diff.save file_path('htm')
    else
      puts "Article has not changed"
    end
  end

  def changed?
   if @history.any?
   puts @history.last.title
     return ((title != @history.last.title)  or (teaser != @history.last.teaser) or (text != @history.last.text))
    else
      true
    end
  end
end