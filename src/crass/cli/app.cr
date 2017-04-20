module Crass
  module CLI
    class App
      # searches the directory for scss file and converts them to css,
      def self.directory_convert(file_array, options)
        file_array.each do |file|
          file_convert file, options if File.extname(file) == ".scss"
        end
      end

      def self.file_convert(filename, options)
        if out_dir = options.output_file
          Dir.mkdir_p(out_dir) unless Dir.exists?(out_dir)
        end
        opts = options.sass_options
        file_ctx = Crass::Context::File.new(filename, opts) if opts
        output_css = file_ctx.compile if file_ctx
        puts filename.colorize(:red) if options.show_filename
        if output_file = options.output_file
          new_file = "/#{File.basename(filename, ".scss")}.css"
          out_file = output_file + new_file
          File.write(out_file, output_css)
        else
          puts output_css
          puts "\n"
        end
      rescue ex : SassError
        puts filename.colorize(:red)
        puts ex.message.colorize(:red)
      rescue file_error : Errno
        puts file_error.message.colorize(:red)
      end

      def self.string_convert(string, options)
        opts = options.sass_options
        data_ctx = Crass::Context::Data.new(string, opts) if opts
        output_css = data_ctx.compile if data_ctx
        puts output_css
      end
    end
  end
end
