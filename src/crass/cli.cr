require "option_parser"
require "./cli/options"
require "./cli/director"
require "./cli/app"
require "colorize"

module Crass
  module CLI
    def self.usage
      <<-USAGE
#{PROGRAM_NAME}   Input (Directory, File, Quoted String)

-o | --ouptut   Output_file, default: STDOUT
-s | --style    One of [NESTED, EXPANDED, COMPACT, COMPRESSED], default: NESTED
-v | --version  Version information
-h | --help     Help me
USAGE
    end

    def self.run
      OptionParser.parse! do |opts|
        options = Options.new

        opts.banner = "#{PROGRAM_NAME} [Input] [Options]"
        opts.on("-F", "--filenames", "show filenames on STDOUT") do |show_filename|
          options.show_filename = show_filename
        end
        opts.on("-o OUTPUT", "--output OUTPUT", "Output path") do |output|
          options.output_file = output
        end
        opts.on("-s STYLE", "--style STYLE", "One of [NESTED, EXPANDED, COMPACT, COMPRESSED]") do |style|
          abort usage unless Crass::SassOutputStyle.names.includes? style.upcase
          options.style = style.upcase
        end
        opts.on("-v", "--version", "version #") do
          puts "LibSass Version: #{Crass.sass_version}"
          puts "Crass Version: #{VERSION}"
          exit 0
        end
        opts.on("-h", "--help", "Help Me!") do
          abort usage
        end

        opts.unknown_args do |args|
          if args.empty?
            puts usage
          else
            Director.runner(args[0], options)
          end
        end
      end
    rescue ex : OptionParser::MissingOption
      puts "Missing option parameter required.".colorize(:red)
      puts usage
    rescue ex : OptionParser::InvalidOption
      puts "Could not find the requested option, it was ignored.".colorize(:red)
      puts usage
    end
  end
end
