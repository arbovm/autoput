require "yaml"

module Autoput
  class Run
    FILE = ".autoput.yml"
    
    attr_reader :framework, :results, :green, :run_at
    
    def initialize(framework, attrs = {})
      @framework = framework
      @results   = attrs[:results]   || []
      @green     = attrs[:green]     || false
      @run_at    = attrs[:run_at]    || Time.now
    end
    
  end
end