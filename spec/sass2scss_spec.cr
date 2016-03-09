require "./spec_helper"

describe Crass::Sass2Scss do
  it "has a version" do
    version = Crass::Sass2Scss.version
    version.should match(/\d+\.\d+\.\d+/)
  end

  it "converts a file" do
    opts = Crass::Sass2Scss::Options.new("MINIFIED", "KEEP")
    convert = Crass::Sass2Scss.convert(File.new("#{FIXTURE_DIR}/test.sass"), nil, opts)
    convert.scss.should contain "#main { color: blue;font-size: 0.3em; }/*"
  end

  it "converts a string" do
    opts = Crass::Sass2Scss::Options.new("MINIFIED", "KEEP")
    str = "#myid
      :color blue
      :margin 5px"
    convert = Crass::Sass2Scss.convert(str, nil, opts)
    convert.scss.should eq "#myid { color: blue;margin: 5px; }"
  end

  it "takes a sass file and writes the convertion to a output file" do
    input_file = File.new("#{FIXTURE_DIR}/test.sass")
    output_file = "#{FIXTURE_DIR}/test.scss"
    opts = Crass::Sass2Scss::Options.new("ALLMAN", "CONVERT")
    convert = Crass::Sass2Scss.convert(input_file, output_file, opts)
    convert.write
    File.exists?(output_file).should be_true
    File.delete(output_file)
  end

  it "takes a sass string and writes the conversion to a output file" do
    output_file = "#{FIXTURE_DIR}/string.scss"
    opts = Crass::Sass2Scss::Options.new("MINIFIED", "KEEP")
    str = "#myid
      :color blue
      :margin 5px"
    convert = Crass::Sass2Scss.convert(str, output_file, opts)
    convert.write
    File.exists?(output_file).should be_true
    File.delete(output_file)
  end
end
