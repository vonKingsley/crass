require "../spec_helper"

describe Crass::Sass2Scss::Options do
  it "returns an output style as enum" do
    sty = Crass::Sass2Scss::Options.new("ALLMAN", "CONVERT")
    sty.output_style.should be_a(Crass::Sass2Scss::Options::OutputStyle::ALLMAN)
  end

  it "returns an comment style as enum" do
    sty = Crass::Sass2Scss::Options.new("ALLMAN", "CONVERT")
    sty.comment_style.should be_a(Crass::Sass2Scss::Options::CommentStyle::CONVERT)
  end

  it "outputs the style as an int" do
    sty = Crass::Sass2Scss::Options.new("ALLMAN", "CONVERT")
    sty.style.should eq 131
    sty = Crass::Sass2Scss::Options.new("MINIFIED", "KEEP")
    sty.style.should eq 32
    sty = Crass::Sass2Scss::Options.new("ONE_TBS", "STRIP")
    sty.style.should eq 66
  end

  it "raises when an invalid option is used" do
    expected_error = "Unknown enum Crass::Sass2Scss::Options::OutputStyle value: BAD_REQ"
    expect_raises(Exception, expected_error) do
      Crass::Sass2Scss::Options.new("BAD_REQ", "CONVERT")
    end
  end
end
