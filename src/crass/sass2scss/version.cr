module Crass
  module Sass2Scss
    def self.version
      String.new(LibSass.sass2scss_version)
    end
  end
end
