require 'spec_helper'

describe Autoput::Customs::Payload do
  
  before(:each) do
    @results = ['Autoput should work', 'Autoput should be awesome']
  end
  
  describe "self#initialize" do
    
    context "with hash as argument" do
      
      subject { Autoput::Customs::Payload.new("cucumber", { :results => @results, :green => false }) }
      
      its(:framework) { should == "cucumber" }
      its(:results) { should == @results }
      its(:green) { should be_false }
      
    end
    
    context "with only the framework argument" do
      
      subject { Autoput::Customs::Payload.new("rspec2") }
      
      its(:framework) { should == "rspec2" }
      its(:results) { should be_empty }
      its(:green) { should be_false }
      
    end
    
  end
  
end