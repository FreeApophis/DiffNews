#!/usr/bin/env ruby
# Diff News
# ----------------------
#
# Changes in Articles over time

# Load library path for development
$LOAD_PATH.unshift File.join(File.dirname(__FILE__), ".")

require 'optparse'
require 'diff_news_factory'
require 'diff_news_grabber'

# Configuration can Override options
options =
{
    help: false,
    scan: false,
    verbose: false,
}

def print_help optparse
  puts optparse.summarize
  exit 0
end

program_version = 'DiffNews 0.1'

# Command Line Parameters
optparse = OptionParser.new do|opts|
  opts.separator program_version 
  opts.separator ''

  opts.on("-V", "--verbose", "More verbose Output.") do
    options[:verbose] = true
  end

  opts.on( '-v', '--version', 'Current Version' ) do
    puts program_version
    exit 0
  end

  opts.on( '-s', '--scan', 'Scan Frontpage' ) do
    options[:scan] = true
  end

  opts.on( '-h', '--help', 'Prints help' ) do
    options[:help] = true
  end

  opts.separator ''
  opts.separator 'Examples:'
  opts.separator ''
end

print_help optparse if ARGV.empty?
optparse.parse!
print_help optparse if options[:help] || ARGV.empty?

if options[:scan]
  while true 
    ARGV.each do |url|
      diff = DiffNewsGrabber.new url
      diff.links.each do |link|
        begin
          puts link
          diff = DiffNewsFactory.create link
        rescue UnknownNewspageError
          puts "No News Handler"
        rescue OpenURI::HTTPError
          puts "404 - Page not found"
        end 
      end 
    end   
    sleep 900
  end

  exit
end

ARGV.each do |url|
  diff = DiffNewsFactory.create url
end
