require 'thor'

module Autoput
  class CLI < Thor
    
    desc "drive", "Run with the given test frameworks"
    method_option :rspec, :type => :boolean, :default => true
    
    def drive
      if options[:rspec]
        framework = "rspec2"
        # Runs the specs and saves the result to the file
        # `rspec spec -r autoput/frameworks/#{framework}`
        exec("rspec spec -r autoput/frameworks/#{framework}")
      end
    end
    
  end
end