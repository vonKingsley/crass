module Crass
  module CLI
    class Options
      @opts : Crass::Options?

      property output_file : String , style : String, show_filename : Bool

      def initialize
        @show_filename = false
        @output_file = ""
        @style = "NESTED"
        @opts = nil
      end

      def sass_options
        @opts ||= Crass::Options.configure do |conf|
          conf.output_style = Crass::SassOutputStyle.parse(@style)
        end
        @opts
      end
    end
  end
end
