#
# Store and retrieve a history by provider and uuid
#

require 'revision'

module DiffNews

  class DefaultHistory
    attr_reader :revisions

    def initialize provider, uuid, url
      @provider = provider
      @uuid = uuid
      @url = url

      @revisions = []
    end
  
    def load
    end

    def store
    end

    def revision_changed? rev1, rev2
      return true if rev1 == nil
      return rev1.title != rev2.title || rev1.teaser != rev2.teaser || rev1.text != rev2.text
    end

    def append_changed_revision title, teaser, text
      new_revision = Revision.new @provider, @uuid, @revisions.count, title, teaser, text
      if revision_changed? @revisions.last, new_revision
        @revisions << new_revision
      end
    end

    def clear
      @revisions.clear
    end
  end

end
