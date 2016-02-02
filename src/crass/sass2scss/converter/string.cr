module Crass
  module Sass2Scss
    class SassString < Converter

      def initialize(input : String, output : String?, options = 0 : Int32)
        super
        convert_to_scss(input)
      end

    end
  end
end
