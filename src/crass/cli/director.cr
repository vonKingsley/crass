module Crass
  module CLI
    class Director
      def self.runner(command, options)
        case
        when File.directory?(command)
          App.directory_convert(Dir["#{command}/**"], options)
        when File.file?(command)
          App.file_convert(command, options)
        else
          App.string_convert(command, options)
        end
      end
    end
  end
end
