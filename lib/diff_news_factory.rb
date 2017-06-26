require 'diff_news_tagesanzeiger'
require 'diff_news_nzz'

class UnknownNewspageError < StandardError
end

class DiffNewsFactory
  def self.create url   
    case url
      when /^https?:\/\/(www.)?tagesanzeiger.ch/
        return DiffNewsTagesanzeiger.new url
      when /^https?:\/\/(www.)?nzz.ch/
        return DiffNewsNzz.new url
      else
        raise UnknownNewspageError
      end
  end
end