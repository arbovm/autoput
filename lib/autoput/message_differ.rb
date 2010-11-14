module Autoput
  class MessageDiffer
  
    def initialize(new_result, old_result)
      @new_msg = new_result
      @old_msg = old_result
    end

    def caption text
      first_new_line = text.index("\n")+1
      text[first_new_line, text.index("\n", first_new_line)]
    end
    
    def commit_msg
      old_specs = specs_to_array @old_msg
      new_specs = specs_to_array @new_msg
      commit_msg = caption(@new_msg)
      new_specs.each do |line|
        unless old_specs.include? line
          line[0] = '+'
          commit_msg += line 
        end
      end
      old_specs.each do |line|
        commit_msg += line unless new_specs.include? line
      end
      commit_msg
    end
    
    def specs_to_array text
      specs = []
      text.each_line do |line|
        specs << line if line.match(/^-.*/) and not line.match(/.*\(FAILED .*/)
      end
      specs
    end
    
  end
end