lib LibC
  fun strcpy(dest : UInt8*, source : UInt8*) : UInt8*
end

module Crass
  module Context
    class Data

      property :sass

      def initialize(@sass : String, new_options = Crass::Options.new : Crass::Options)
        sass_string = LibC.malloc(@sass.bytesize) as UInt8*
        LibC.strcpy(sass_string, @sass)
        @data_ctx = LibSass.sass_make_data_context(sass_string)
        @ctx = LibSass.sass_data_context_get_context(@data_ctx)
        options = options.merge(new_options)
      end

      def compile
        result = LibSass.sass_compile_data_context(@data_ctx)
        if result == 0
          output
        else
          begin
            raise Crass::SassError.new(error)
          ensure
            delete
          end
        end
      end

      def output
        String.new(LibSass.sass_context_get_output_string(@ctx))
      end

      def error
        String.new(LibSass.sass_context_get_error_message(@ctx))
      end

      def compiler
        Crass::Compiler.new(LibSass.sass_make_data_compiler(@data_ctx))
      end

      def options=(opts)
        LibSass.sass_data_context_set_options(@data_ctx, opts.lib_options)
      end

      def options
        Crass::Options.new(LibSass.sass_data_context_get_options(@data_ctx))
      end

      def delete
        LibSass.sass_delete_data_context(@data_ctx)
      end

      def to_s
        @sass
      end

      def inspect
        "#<#{self.class.name}:0x##{object_id.to_s(16)}>"
      end
    end
  end
end
