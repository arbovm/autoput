$:.unshift(File.dirname(__FILE__) + '/../lib') unless $:.include?(File.dirname(__FILE__) + '/../lib')

require 'autoput/message_differ'
require 'autoput/customs'
require 'autoput/run'

module Autoput
end
