ENV['CONSOLE_DEVICE'] ||= 'stdout'
ENV['LOG_LEVEL'] ||= 'info'
ENV['LOG_TAGS'] = '_untagged,message'

puts RUBY_DESCRIPTION

require_relative '../init.rb'

require 'pp'

include AccountComponent
