#
# News Service Factory
#

require 'uuidtools'
require 'nokogiri'
require 'open-uri'

require 'default_history'

module DiffNews

  class UnknownNewspageError < StandardError
  end

  class Service
    attr_reader :history, :url

    @@services = []
    @@store_class = DefaultHistory

    def self.services
      @@services
    end

    def provider
      self.class.provider
    end

    def base_url
      self.class.base_url
    end

    def encoding
      @doc.encoding
    end
  
    def current_revision
      return @history.revisions.last
    end

    def self.store_class= store_class
      @@store_class = store_class
    end

    def initialize url
      @url = url
      @uuid = UUIDTools::UUID.sha1_create(UUIDTools::UUID_URL_NAMESPACE, url)
      load_document
      load_history
    end
  
    def self.register_service
      @@services << self
    end

    def self.create url
      match = @@services.select { |s| url =~ s.valid_url }
      raise UnknownNewspageError if match.none?

      match.first.new url
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

  private
    def load_document
      @doc = Nokogiri::HTML(open(@url))
    end

    def load_history
      @history = @@store_class.new provider, @uuid

      @history.load
      @history.append_changed_revision title, teaser, text
      @history.store
    end
  end

end
