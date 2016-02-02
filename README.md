# Crass
Crystal Sass

Bindings for libsass

## Installation

Mac: `brew install libsass`

Linux: I'm working on instructions

Add this to your application's `shard.yml`:

```yaml
dependencies:
  crass:
    github: vonkingsley/crass
```


## Usage


```crystal
require "crass"
```

Start with creating some options or use the defaults
```crystal
opts = Crass::Options.configure do |conf|
  conf.precision = 8
  conf.linefeed = "\n\n"
end
```
Or

```crystal
opts = {:precision => 4, :input_file => "/home/user/borders.scss"}

```
Or

```crystal
opts = Crass::Options.new
opts.precision = 8
opts.output_style = Crass::SassOutputStyle::COMPRESSED
```
Options:
```crystal
{
:precision => Int32, 
:output_style => Crass::SassOutputStyle, 
:source_comments => Bool, 
:source_map_embed => Bool,
:source_map_contents => Bool, 
:omit_source_map_url => Bool, 
:is_indented_syntax_src => Bool,
:indent => String, 
:linefeed => String, 
:input_path => String, 
:output_path => String, 
:plugin_path => String, 
:include_path => String,
:source_map_file => String, 
:source_map_root => String
}
```
## Create a Context
## [Data]
```crystal
ctx = Crass::Context::Data.new("$five: 5px;\n#main{margin: $five;}", opts)
output = ctx.compile #=> output css
puts output
rescue e : Crass::SassError
  puts e.message
ensure
  #free the context when you are done, please.
  ctx.delete if ctx
```

## [File]
```crystal
ctx = Crass::Context::File.new("/home/user/margins.scss", opts)
output = ctx.compile #=> output css
puts output
rescue e: Crass::SassError
  puts e.message
ensure
  #free the context when you are done, please.
  ctx.delete if ctx
```
You can also create a file context with the default options with just a
File object or filename
```crystal
ctx = Crass::Context::File("/home/user/index.scss")
```
Or

```crystal
my_sass = File.new("/home/user/padding.scss")
ctx = Crass::Context::File(my_sass)
```

## Compiler
You may want more control and timing of the compile process.

Create a context and get the compiler
```crystal
ctx = Crass::Context::File.new("/home/user/home.scss", opts)
compiler = ctx.compiler
compiler.parse
puts compiler.state
compiler.execute
puts compiler.state
ctx.output
```


## Command line
You can use the above library within your code or the command line to convert your files or directories
```crystal
crystal build src/crass.cr
crass -h
```
If you have original style sass and want scss output you can build my
version of the sass2scss tool
```bash
crystal build src/sass2scss.cr
sass2scss -h
```

## TODO
 - [ ] Sass Values

 - [ ] Sass Function

 - [ ] Sass Importer 

 - [ ] A lot more error control

## Contributing

1. Fork it ( https://github.com/vonkingsley/crass/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [vonKingsley](https://github.com/vonkingsley) Kingsley Lewis - creator, maintainer
