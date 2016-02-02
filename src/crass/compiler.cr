module Crass
  class Compiler
    def initialize(@compiler)
    end

    def parse
      LibSass.sass_compiler_parse(@compiler)
    end

    def execute
      LibSass.sass_compiler_execute(@compiler)
    end

    def state
      LibSass.sass_compiler_get_state(@compiler)
    end

    def context
      LibSass.sass_compiler_get_context(@compiler)
    end

    def options
      LibSass.sass_compiler_get_options(@compiler)
    end

    def delete
      LibSass.sass_delete_compiler(@compiler)
    end
  end
end
