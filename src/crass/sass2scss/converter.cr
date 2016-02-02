module Crass
  module Sass2Scss

    def self.convert(input : T, output : String?, options : Crass::Sass2Scss::Options)
      case input
      when File
        converter = Crass::Sass2Scss::SassFile.new(input, output, options.style)
      when String
        converter = Crass::Sass2Scss::SassString.new(input, output, options.style)
      end
      converter as Converter
    end

    class Converter

      getter :scss

      def initialize(@input : T, @output = nil : String?, @options = 0 : Int32)
        @scss = ""
      end

      def write
        if output = @output
          File.write(output, @scss)
        else
          puts @scss
        end
      end

      private def convert_to_scss(lines)
        @scss = String.new(LibSass.sass2scss(lines, @options))
      end

    end
  end
end

require "./converter/file"
require "./converter/string"
