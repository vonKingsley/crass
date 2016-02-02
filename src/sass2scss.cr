require "./crass/lib_sass"
require "./crass/sass2scss/version"
require "./crass/sass2scss/options"
require "./crass/sass2scss/converter"
require "./crass/sass2scss/cli"

module Crass
  module Sass2Scss
    Crass::Sass2Scss::CLI.run
  end
end
