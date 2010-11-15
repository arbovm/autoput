module Autoput
  module Frameworks
    class RSpec2
      def self.declare(config)
        payload = Autoput::Customs::Payload.new('rspec2',
          :green => config.formatter.failed_examples.empty?,
          :results => config.formatter.failed_examples.map(&:full_description))
        Autoput::Customs::Entry.add_payload(payload)
      end
    end
  end
end

# Configure RSpec so that our handler gets
# invoked after running the spec suite
RSpec.configure do |config|
  config.after(:suite) do
    Autoput::Frameworks::RSpec2.declare(config)
  end
end