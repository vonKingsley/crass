require "../converter"

module Crass
  module Sass2Scss
    class SassFile < Converter
      def initialize(input : File, output = nil : String?, options = 0 : Int32)
        super
        lines = [] of String
        input.each_line do |line|
          lines << line
        end
        convert_to_scss(lines.join)
      end
    end
  end
end
