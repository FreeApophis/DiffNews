# encoding: UTF-8

require 'json'

class NewsObject
  attr_accessor :title, :teaser, :text

  def initialize
    @title = ''
    @teaser = ''
    @text = ''
  end

  def load file
    data = JSON.parse(File.open(file, 'r:UTF-8', &:read))
    @title = data['title']
    @teaser = data['teaser']
    @text = data['text']
  end
  
  def save file
    data = { title: title, teaser: teaser, text: text}
    File.open(file, 'w:UTF-8') do |f|
      f.write(data.to_json)
    end
  end

end