require "./crass/**"

module Crass

  def self.sass_version
    String.new(LibSass.libsass_version)
  end

end
Crass::CLI.run
