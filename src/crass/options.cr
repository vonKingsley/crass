module Crass
  class Options
    getter :options, :lib_options

    def initialize(@lib_options : LibSass::SassOptions* = LibSass.sass_make_options)
    end

    def self.new(hash : Hash(Symbol, Nil | Crass::SassOutputStyle | String | Int32 | Bool))
      opts = new
      merged_options = opts.options.merge(hash)
      opts.config_from_hash merged_options
    end

    def self.configure
      opts = new
      yield opts
      opts
    end

    def inspect
      "#<#{self.class.name}:0x##{object_id.to_s(16)}>"
    end

    def to_s
      inspect
    end

    # Contexts will have their own set of defaults when said context is created.
    # Things like input_path get overwritten if you pass in a new options.
    # This method will merge the options self gets others options
    def merge(other : Crass::Options)
      self_hash = self.options
      other_hash = other.options
      merged = self_hash.merge(other_hash)
      config_from_hash merged
    end

    OPTIONS_DEF_HASH = {:precision => Int32, :output_style => Crass::SassOutputStyle, :source_comments => Bool, :source_map_embed => Bool,
      :source_map_contents => Bool, :omit_source_map_url => Bool, :is_indented_syntax_src => Bool,
      :indent => String, :linefeed => String, :input_path => String, :output_path => String, :plugin_path => String, :include_path => String,
      :source_map_file => String, :source_map_root => String}

    {% for meth, type in OPTIONS_DEF_HASH %}

      def {{meth.id}}
        {% if type.stringify == "String" %}
             str = LibSass.sass_option_get_{{meth.id}}(@lib_options)
             String.new(str) if str
        {% else %}
            LibSass.sass_option_get_{{meth.id}}(@lib_options)
        {% end %}
      end

      def {{meth.id}}=(val : {{type}})
        LibSass.sass_option_set_{{meth.id}}(@lib_options, val)
      end

    {% end %}

    # returns the list of current options
    def options
      options_hash = Hash(Symbol, Nil | String | Int32 | Bool | Crass::SassOutputStyle).new
      {% for meth in OPTIONS_DEF_HASH.keys %}
        options_hash[{{meth}}] = {{meth.id}}
      {% end %}
      options_hash
    end

    # Use a hash to create the options, may come in handy some day
    macro def config_from_hash(hash) : Crass::Options
      {% for meth, type in OPTIONS_DEF_HASH %}
          self.{{meth.id}}=(hash[{{meth}}] as {{type.id}}) unless hash[{{meth}}].nil?
      {% end %}
      self
    end
  end
end
