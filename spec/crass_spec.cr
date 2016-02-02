require "./spec_helper"

describe Crass do
  # TODO: Write tests

  it "returns a version" do
    ver = Crass.sass_version
    ver.should eq("3.3.2")
  end

  it "takes a file and outputs a new correctly compiled file" do
  end

  it "takes a directory and outputs every scss file to css" do
  end
end
