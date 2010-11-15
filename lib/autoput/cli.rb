require 'thor'

module Autoput
  class CLI < Thor
    
    default_task :drive
    
    desc "drive", "Run with the given test frameworks"
    method_option :rspec, :type => :boolean, :default => true
    
    def drive
      system("rspec spec -r autoput/frameworks/rspec2") if options[:rspec]
      
      # Get the runs and perform actions based on the runs status
      curr_run, prev_run = Autoput::Customs::Entry.payloads("rspec2")
      unless curr_run.green
        phase = "RED (working on new commit)"
        message = curr_run.results.join("\n")
      else
        differ = Autoput::Customs::EntryCertificate.new(curr_run.result, prev_run.result)
        message = differ.commit_msg
        if prev_run.green
          phase = "REFACTOR (amending commit)"
          git_cmd = "git commit -a --amend -m '#{message}'"
        else
          phase = "GREEN (new commit)"
          git_cmd = "git commit -a -m '#{message}'"
        end
        # system(git_cmd)
      end
      puts "\n↑ #{phase} ↑\n\n#{message}\n\n"
    end
    
  end
end