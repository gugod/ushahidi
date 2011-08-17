require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ushahidi" do
end

describe "Ushahidi::Report" do
  it "can be posted" do
    u = Ushahidi::Report.new
    u.respond_to?(:post).should be_true
  end
end
