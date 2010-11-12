require "yaml"

PROPERIES_FILE = ".autoput.yml"

class SpecMsgDiffer

  def caption text
    first_new_line = text.index("\n")+1
    text[first_new_line, text.index("\n",first_new_line)]
  end

  def specs_to_array text
    specs = []
    text.each_line do |line|
      specs << line if line.match(/^-.*/) and not line.match(/.*\(FAILED .*/)
    end
    specs
  end
  
  def initialize(old_spec_output, new_spec_output)
    @new_msg=new_spec_output
    @old_msg=old_spec_output
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
end


current_spec_result = `spec spec/*spec.rb -f specdoc`
green_bar = $?.success?

puts "---\n#{current_spec_result}\n---"

props = YAML.load(File.read(PROPERIES_FILE)) rescue {:last_run_was_green => false, :last_failed_spec_result => ""}

if (green_bar)
  
	msg = SpecMsgDiffer.new(props[:last_failed_spec_result], current_spec_result).commit_msg
	
	if (props[:last_run_was_green]) 
	  
	  puts "~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~"
		puts "~~ refactoring on green bar"
		puts "~~ git commit -a --amend -m '#{msg}'"
		puts "~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~"
		
		`git commit -a --amend -m '#{msg}'`
	else
	  
	  puts "~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~"
		puts "~~ green bar"
		puts "~~ git commit -a -m '#{msg}'"
	  puts "~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~ ~~~~"
	  
		`git commit -a -m '#{msg}'`
	end
	props[:last_run_was_green] = true
else
	if (props[:last_run_was_green] or props[:last_failed_spec_result].empty?)
		props[:last_failed_spec_result] = current_spec_result
	end
	props[:last_run_was_green] = false
end

File.open(PROPERIES_FILE, "w") do |f|
  f.write(props.to_yaml)
end


