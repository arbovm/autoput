require "yaml"

module Autoput
  module Customs
    class Entry
      FILE = ".autoput.yml"
      
      # Inserts new payload into the file and
      # limits to two payloads per framework.
      def self.add_payload(payload)
        c = self.contents
        payloads = c[payload.framework] || []
        payloads.unshift({
          :green => payload.green,
          :results => payload.results,
          :run_at => payload.run_at })
        c[payload.framework] = payloads[0..1]
        File.open(FILE, "w") { |f| f.write(c.to_yaml) }
      end
      
      # Deserializes the runs
      def self.payloads(framework)
        (self.contents[framework] || []).map do |attrs|
          Payload.new(framework, attrs)
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
end