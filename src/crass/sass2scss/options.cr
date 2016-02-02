module Crass
  module Sass2Scss
    class Options

      @output_style : OutputStyle
      @comment_style : CommentStyle

      enum OutputStyle
        # Indent Styles
        MINIFIED = 0
        LISP     = 1
        ONE_TBS  = 2
        ALLMAN   = 3
      end

      enum CommentStyle
        KEEP    =  32
        STRIP   =  64
        CONVERT = 128
      end

      property :output_style, :comment_style

      def initialize(output_style : String, comment_style : String)
        #defaults
        @output_style = OutputStyle::MINIFIED
        @comment_style = CommentStyle::KEEP
        self.output_style = output_style
        self.comment_style = comment_style
      end

      def output_style=(style : String)
        @output_style = OutputStyle.parse(style)
      end

      def comment_style=(style : String)
        @comment_style = CommentStyle.parse(style)
      end

      def style
        @output_style.value | @comment_style.value
      end
    end
  end
end
