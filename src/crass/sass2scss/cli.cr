require "option_parser"

module Crass
  module Sass2Scss
    class CLI

      def self.run
        input = ""
        output = nil
        style = "ALLMAN"
        comment = "CONVERT"
        op = OptionParser.new do |opts|
          opts.banner = usage
          opts.on("-i INPUT", "--input INPUT ", "Input file or string") do |inp|
            input = inp
            input = File.new(inp) if File.exists?(inp)
          end
          opts.on("-o OUTPUT_FILE", "--output OUTPUT_FILE ", "Output file which will be written to") {|outp|  output = outp}
          opts.on("-s [MINIFIED, LISP, ONE_TBS, ALLMAN] ", "--style [MINIFIED, LISP, ONE_TBS, ALLMAN]", "Output style" ) {|styl| style = styl.upcase}
          opts.on("-c [KEEP, STRIP, CONVERT]", "--comment [KEEP, STRIP, CONVERT] ", "Comment style") {|com| comment = com.upcase}
          opts.on("-h", "--help", "Help Me!") do
            abort usage
          end
        end
        op.parse!
        options = Crass::Sass2Scss::Options.new(style, comment)
        converter = Crass::Sass2Scss.convert(input, output, options)
        converter.write
      rescue ex : OptionParser::MissingOption | OptionParser::InvalidOption
        abort usage
      end

      def self.usage
        <<-USAGE
          #{PROGRAM_NAME}
            -i | --input    string or file, if you use a string wrap it in $' '
            -o | --ouptut   output_file, default: STDOUT
            -s | --style    one of [MINIFIED, LISP, ONE_TBS, ALLMAN], default: ALLMAN
            -c | --comment  one of [KEEP, STRIP, CONVERT] , default: CONVERT
            -h | --help     help me
        USAGE
      end

    end
  end
end
