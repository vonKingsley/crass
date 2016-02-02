require "./spec_helper"

describe Crass::Compiler do
  it "parses and has the PARSED SassCompilerState" do
    compiler = Crass::Context::Data.new("#media{ margin: 2em + 3em; }").compiler
    compiler.parse
    compiler.state.should eq(LibSass::SassCompilerState::PARSED)
  end

  it "executes and sets the EXECUTED SassCompilerState" do
    data = Crass::Context::Data.new("$five_px: 5px; #main{ margin: $five_px; }")
    compiler = data.compiler
    compiler.parse
    compiler.execute
    compiler.state.should eq(LibSass::SassCompilerState::EXECUTED)
  end
end
