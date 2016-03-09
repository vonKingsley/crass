module Crass
  module CLI
    class Options
      property :output_file, :style, :show_filename

      def initialize
        @show_filename = nil
        @output_file = nil
        @style = "NESTED"
        @opts = nil # Crass::Options.new
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
