require 'rake/testtask'
require_relative 'lib/diff_news'

task :default => [:test]

Rake::TestTask.new do |t|
  t.libs << "lib"
  t.test_files = Dir["test/*.rb"]
end
desc "Run tests for diff_news"

task :providers do
  examples = [
    'http://www.tagesanzeiger.ch/sport/tennis/aufschlag-smash-und-tschuess/story/10062709',
    'https://www.nzz.ch/finanzen/abgang-eines-wichtigen-softwarespezialisten-die-tesla-aktie-hat-derzeit-gegenwind-ld.1304770',
    'http://www.20min.ch/schweiz/zuerich/story/Auf-der-Hardbruecke-gibts-Boden-Ampeln-fuer-Velos-14061461',
    'http://www.faz.net/aktuell/politik/inland/ehe-fuer-alle-bundesrat-stimmt-oeffnung-der-ehe-zu-15095538.html',
  ]

  examples.each do |example|
    service = DiffNews::Service::create example
    puts '=' * 100
    puts service.provider
    puts service.current_revision.title
    puts service.current_revision.teaser
  end
end
