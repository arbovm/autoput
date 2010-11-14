require "yaml"

module Autoput
  class Customs
    FILE = ".autoput.yml"
    
    # Inserts new run into the file and limits to two runs per framework.
    def self.add_run(run)
      c = self.contents
      runs = c[run.framework] || []
      runs.unshift({
        :green => run.green,
        :results => run.results,
        :run_at => run.run_at })
      c[run.framework] = runs[0..1]
      File.open(FILE, "w") { |f| f.write(c.to_yaml) }
    end
    
    # Deserializes the runs
    def self.runs(framework)
      (self.contents[framework] || []).map do |attrs|
        Autoput::Run.new(framework, attrs)
      end
    end
    
    private
    
    # Returns te content of the file as a hash with framework names as keys.
    # Example file structure:
    # --- 
    # rspec2: 
    # - :run_at: 2010-11-14 23:15:28.689005 +01:00
    #   :green: true
    #   :results:
    # - :run_at: 2010-11-14 23:12:21.467073 +01:00
    #   :green: false
    #   :results: 
    #   - Testspec for Autoput should fail
    #   - Testspec for Autoput with more detail should fail
    #   - Testspec for Autoput with more detail when stacked should fail
    
    def self.contents
      YAML.load(File.read(FILE)) || {}
    end
    
  end
end