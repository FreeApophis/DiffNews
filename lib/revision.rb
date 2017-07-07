#
# POD for revision, container for the revision data stored in file or db
#

module DiffNews
  Revision = Struct.new("Revision", :provider, :uuid, :revision, :title, :teaser, :text)
end
