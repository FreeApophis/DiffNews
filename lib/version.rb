#
# Version of vcs.rb
#

module DiffNews
  def self.version_path
    File.expand_path("version.info", File.dirname(__FILE__))
  end

  def self.version
    File.open(version_path, &:readline)
  end
end

$vcs_ruby_version = Gem::Version.new(DiffNews::version)
$vcs_ruby_name = 'DiffNews makes changes visible'
$vcs_ruby_short = 'diff_news'
