module Crass
  VERSION = "0.1.1"

  def self.sass_version
    String.new(LibSass.libsass_version)
  end
end
