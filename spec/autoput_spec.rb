require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Testspec for Autoput" do
  
  it "should be pending" do
    pending
  end
  
  it "should pass" do
    true.should be_true
  end
  
  it "should fail" do
    false.should be_true
  end
  
  describe "with more detail" do
    it "should fail" do
      false.should be_true
    end
    
    context "when stacked" do
      it "should fail" do
        false.should be_true
      end
    end
  end
  
end