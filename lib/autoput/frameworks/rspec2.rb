module Autoput
  module Frameworks
    class RSpec2
      def self.handle(config)
        run = Autoput::Run.new('rspec2',
          :green => config.formatter.failed_examples.empty?,
          :results => config.formatter.failed_examples.map(&:full_description))
        Autoput::Customs.add_run(run)
        
        # Get the runs and perform actions based on the runs status
        curr_run, prev_run = Autoput::Customs.runs("rspec2")
        unless curr_run.green
          phase = "RED (working on new commit)"
          message = curr_run.results.join("\n")
        else
          differ = MessageDiffer.new(curr_run.result, prev_run.result)
          message = differ.commit_msg
          if prev_run.green
            phase = "REFACTOR (amending commit)"
            git_cmd = "git commit -a --amend -m '#{message}'"
          else
            phase = "GREEN (new commit)"
            git_cmd = "git commit -a -m '#{message}'"
          end
          # `#{git_cmd}`
        end
        puts "\n↑ #{phase} ↑\n\n#{message}\n\n"
        
      end
    end
  end
end

# Configure RSpec so that our handler gets
# invoked after running the spec suite
RSpec.configure do |config|
  config.after(:suite) do
    Autoput::Frameworks::RSpec2.handle(config)
  end
end