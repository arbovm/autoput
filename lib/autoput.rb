$:.unshift(File.dirname(__FILE__) + '/../lib') unless $:.include?(File.dirname(__FILE__) + '/../lib')

require 'autoput/customs/check'
require 'autoput/customs/entry'
require 'autoput/customs/entry_certificate'
require 'autoput/customs/payload'

module Autoput
end
