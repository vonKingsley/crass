require "./spec_helper"

def options_hash
  {:precision => 12, :source_comments => true, :input_path => "/random_path/file.scss", :output_path => "/my_out"}
end

describe Crass::Options do
  it "returns default options" do
    opts = Crass::Options.new
    opts.precision.should eq(5)
    opts.output_style.should eq(Crass::SassOutputStyle::NESTED)
    opts.source_comments.should be_false
    opts.source_map_embed.should be_false
    opts.source_map_contents.should be_false
    opts.omit_source_map_url.should be_false
    opts.is_indented_syntax_src.should be_false
    opts.indent.should eq("  ")
    opts.linefeed.should eq("\n")
    opts.input_path.should be_nil
    opts.output_path.should be_nil
    opts.plugin_path.should be_nil
    opts.include_path.should be_nil
    opts.source_map_file.should be_nil
    opts.source_map_root.should be_nil
  end

  it "sets an option" do
    opts = Crass::Options.new
    opts.precision = 10
    opts.precision.should_not eq(15)
    opts.precision.should eq(10)
    opts.output_path = "/myout"
    opts.output_path.should eq("/myout")
  end

  it "takes a options block" do
    opts = Crass::Options.configure do |options|
      options.precision = 12
      options.source_comments = true
      options.input_path = "/random_path/file.scss"
    end
    opts.precision.should eq(12)
    opts.source_comments.should be_true
    opts.input_path.should eq("/random_path/file.scss")
  end

  it "takes a options hash" do
    opts = Crass::Options.new(options_hash)
    opts.precision.should eq(12)
    opts.source_comments.should be_true
  end

  it "shows an output hash" do
    opts = Crass::Options.new
    opts.options.should be_a(Hash(Symbol, (Nil | String | Int32 | Bool | Crass::SassOutputStyle)))
  end

  it "updates the output hash" do
    opts = Crass::Options.new
    opts.options[:plugin_path].should be_nil
    opts.plugin_path = "/my_plugins"
    opts.precision = 8
    opts.options[:precision].should eq(8)
    opts.precision = 10
    opts.options[:precision].should eq(10)
    opts.options[:plugin_path].should eq("/my_plugins")
  end

  it "merges two options together" do
    first = Crass::Options.new
    first.precision.should eq(5)
    other = Crass::Options.configure do |opts|
      opts.precision = 12
      opts.source_comments = true
    end
    first.merge other
    first.precision.should eq(12)
    first.output_path.should be_falsey
  end
end
