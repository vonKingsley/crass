require "../spec_helper"

def scss_string
  "$five_px: 5px; #main{ margin: $five_px; }"
end

def scss_error_string
  "#main{
    margin 3px + 2px;}"
end

describe Crass::Context::Data do
  it "returns the request string with to_s" do
    scss = scss_string
    data = Crass::Context::Data.new(scss)
    data.to_s.should eq(scss_string)
  end

  it "returns a formated string" do
    scss = scss_string
    data = Crass::Context::Data.new(scss)
    data.compile
    data.output.should eq("#main {\n  margin: 5px; }\n")
  end

  it "raises an error" do
    data = Crass::Context::Data.new(scss_error_string)
    expected_error = "Error: property \"margin\" must be followed by a ':'"
    expect_raises(Crass::SassError, expected_error) do
      data.compile
    end
  end

  it "has an error" do
    data = Crass::Context::Data.new(scss_error_string)
    compiler = data.compiler
    compiler.parse
    compiler.execute
    expected_error = "Error: property \"margin\" must be followed by a ':'\n        on line 2 of stdin\n>>     margin 3px + 2px;}\n   ----^\n"
    data.error.should eq(expected_error)
  end

  describe "#options" do
    it "returns sass options for the context" do
      data_ctx = Crass::Context::Data.new(scss_string)
      data_ctx.options.class.should eq(Crass::Options)
      # weird compiler bug or I'm doing something wrong, probably the latter -got I must have a inspect method
      Crass::Context::Data.new(scss_string).options.should be_a(Crass::Options)
    end
  end

  describe "#compiler" do
    it "should return a Crass::Compiler" do
      Crass::Context::Data.new(scss_string).compiler.should be_a(Crass::Compiler)
    end
  end
end
