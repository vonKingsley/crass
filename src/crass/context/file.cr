module Crass
  module Context
    class File

      property :sass


      def initialize(@sass : ::File, new_options = Crass::Options.new : Crass::Options)
        @file_ctx = LibSass.sass_make_file_context(@sass.path)
        @ctx = LibSass.sass_file_context_get_context(@file_ctx)
        options = options.merge(new_options)
      end

      def self.new(filename : String, options : Crass::Options)
        new(::File.new(filename), options)
      end

      def self.new(filename : String)
        new(::File.new(filename))
      end

      #compile the file into css and return the results as a string
      #Im sure a string isn't efficient.
      def compile
        result = LibSass.sass_compile_file_context(@file_ctx)
        if result == 0
          output
        else
          begin
            raise Crass::SassError.new(error)
          ensure
            delete
          end
        end
        output
      end

      def output
        String.new(LibSass.sass_context_get_output_string(@ctx))
      end

      def error
        String.new(LibSass.sass_context_get_error_message(@ctx))
      end

      #Use the compiler if you wish to manually parse and execute.
      #This will give you finer control over compiling the scss.
      def compiler
        Crass::Compiler.new(LibSass.sass_make_file_compiler(@file_ctx))
      end

      def options=(opts)
        LibSass.sass_file_context_set_options(@file_ctx, opts.lib_options)
      end

      def options
        Crass::Options.new(LibSass.sass_file_context_get_options(@file_ctx))
      end

      #Releases the file context
      def delete
        LibSass.sass_delete_file_context(@file_ctx)
      end

      def to_s
        inspect
      end

      def inspect
        "#<#{self.class.name}:0x##{object_id.to_s(16)}>"
      end

    end
  end
end
