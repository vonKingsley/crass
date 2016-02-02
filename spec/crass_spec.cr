require "./spec_helper"
describe Crass do
  # TODO: Write tests

  it "returns a version" do
    ver = Crass.sass_version
    ver.should match(/\d+.\d+.\d+/)
  end

end
