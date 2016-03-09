module Crass
  module Sass2Scss
    class SassString < Converter
      def initialize(input : String, output : String?, options : Int32 = 0)
        super
        convert_to_scss(input)
      end
    end
  end
end
