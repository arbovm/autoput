require File.dirname(__FILE__) + '/../autoput.rb'

describe SpecMsgDiffer do
  it "should work with empty strings and yield empty message" do
    
spec_result = "
Array when executing binary search for 10
- should find it at index 0 in [10]
- should find it at index 1 in [9,10]
- should find it at index 1 in [9,10]
- should find it at index 1 in [1,10]
- should find it at index 1 in [1,99,10]
- should find it at index 1 in [1,88,10]
- should find it at index 1 in [1,77,10]

Finished in 0.032773 seconds

7 examples, 0 failures
"
    SpecMsgDiffer.new("", spec_result).commit_msg.should be_empty
  end
end