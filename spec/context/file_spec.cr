require "../spec_helper"

def get_sass_file
  "#{FIXTURE_DIR}/spec.scss"
end

def get_bad_sass_file
  "#{FIXTURE_DIR}/bad_spec.scss"
end

describe Crass::Context::File do

  it "it initializes with a File" do
    file = Crass::Context::File.new(::File.new(get_sass_file))
    file.should be_a(Crass::Context::File)
  end

  it "initiliazes with a filename as a String" do
    file = Crass::Context::File.new(get_sass_file)
    file.should be_a(Crass::Context::File)
  end

  it "takes options" do
    options = Crass::Options.configure do |conf|
       conf.precision = 8
       conf.indent = ""
       conf.output_style = Crass::SassOutputStyle::COMPRESSED
    end
    file = Crass::Context::File.new(get_sass_file, options)
    file.compile
    file.output.should_not contain(" ")
    file.options.precision.should eq(8)
  end

  it "compiles a scss file" do
    file = Crass::Context::File.new(get_sass_file)
    file.compile.should contain("padding: 6px; }")
  end

  it "raises an error if the scss is bad" do
    file = Crass::Context::File.new(get_bad_sass_file)
    expected_error = "Error: property \"height\" must be followed by a ':'"
    expect_raises(Crass::SassError, expected_error) do
      file.compile
    end
  end

  it "has an error when manually compiled" do
    file = Crass::Context::File.new(get_bad_sass_file)
    compiler = file.compiler
    compiler.parse
    compiler.execute
    expected_error = "Error: property \"height\" must be followed by a ':'\n        on line 8 of spec/fixtures/bad_spec.scss\n>>   height $five;\n   --^\n"
    file.error.should eq(expected_error)
  end
end
