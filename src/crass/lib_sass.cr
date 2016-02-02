require "./output_style"
@[Link("sass")]

lib LibSass
  enum SassCompilerState
    CREATED
    PARSED
    EXECUTED
  end

  type SassOptions = Void*
  type SassContext = Void*
  type SassCompiler = Void*
  type SassFileContext = Void*
  type SassDataContext = Void*
  type SassImporterList = Void*
  type SassFunctionList = Void*

  fun libsass_version : UInt8*

  # Options
  fun sass_make_options : SassOptions*

  # Context
  fun sass_make_file_context(input_path : UInt8*) : SassFileContext*
  fun sass_make_data_context(source_string : UInt8*) : SassDataContext*
  fun sass_file_context_get_context(file_ctx : SassFileContext*) : SassContext*
  fun sass_data_context_get_context(data_ctx : SassDataContext*) : SassContext*

  # Context Setters
  fun sass_file_context_set_options(file_ctx : SassFileContext*, opt : SassOptions*) : Void
  fun sass_data_context_set_options(data_ctx : SassDataContext*, opt : SassOptions*) : Void

  # Context Options Getters
  fun sass_context_get_options(ctx : SassContext*) : SassOptions*
  fun sass_file_context_get_options(file_ctx : SassFileContext*) : SassOptions*
  fun sass_data_context_get_options(data_ctx : SassDataContext*) : SassOptions*

  # Compile
  fun sass_compile_file_context(file_ctx : SassFileContext*) : Int32
  fun sass_compile_data_context(data_ctx : SassDataContext*) : Int32

  # Compiler
  fun sass_make_file_compiler(file_ctx : SassFileContext*) : SassCompiler*
  fun sass_make_data_compiler(data_ctx : SassDataContext*) : SassCompiler*
  fun sass_compiler_parse(compiler : SassCompiler*) : Int32
  fun sass_compiler_execute(compiler : SassCompiler*) : Int32
  fun sass_delete_compiler(compiler : SassCompiler*) : Void
  fun sass_compiler_get_state(compiler : SassCompiler*) : SassCompilerState
  fun sass_compiler_get_context(compiler : SassCompiler*) : SassContext*
  fun sass_compiler_get_options(compiler : SassCompiler*) : SassOptions*

  # Option Setters
  fun sass_option_set_precision(opt : SassOptions*, precision : Int32)
  fun sass_option_set_output_style(opt : SassOptions*, output_style : Crass::SassOutputStyle)
  fun sass_option_set_source_comments(opt : SassOptions*, source_comments : Bool)
  fun sass_option_set_source_map_embed(opt : SassOptions*, source_map_embed : Bool)
  fun sass_option_set_source_map_contents(opt : SassOptions*, source_map_contents : Bool)
  fun sass_option_set_omit_source_map_url(opt : SassOptions*, omit_source_map_url : Bool)
  fun sass_option_set_is_indented_syntax_src(opt : SassOptions*, is_indented_syntax_src : Bool)
  fun sass_option_set_indent(opt : SassOptions*, indent : UInt8*)
  fun sass_option_set_linefeed(opt : SassOptions*, linefeed : UInt8*)
  fun sass_option_set_input_path(opt : SassOptions*, input_path : UInt8*)
  fun sass_option_set_output_path(opt : SassOptions*, output_path : UInt8*)
  fun sass_option_set_plugin_path(opt : SassOptions*, plugin_path : UInt8*)
  fun sass_option_set_include_path(opt : SassOptions*, include_path : UInt8*)
  fun sass_option_set_source_map_file(opt : SassOptions*, source_map_file : UInt8*)
  fun sass_option_set_source_map_root(opt : SassOptions*, source_map_root : UInt8*)
  fun sass_option_set_c_headers(opt : SassOptions*, c_headers : SassImporterList*)
  fun sass_option_set_c_importers(opt : SassOptions*, c_importers : SassImporterList*)
  fun sass_option_set_c_functions(opt : SassOptions*, c_functions : SassFunctionList*)

  # Option Getters
  fun sass_option_get_precision(opt : SassOptions*) : Int32
  fun sass_option_get_output_style(opt : SassOptions*) : Crass::SassOutputStyle
  fun sass_option_get_source_comments(opt : SassOptions*) : Bool
  fun sass_option_get_source_map_embed(opt : SassOptions*) : Bool
  fun sass_option_get_source_map_contents(opt : SassOptions*) : Bool
  fun sass_option_get_omit_source_map_url(opt : SassOptions*) : Bool
  fun sass_option_get_is_indented_syntax_src(opt : SassOptions*) : Bool
  fun sass_option_get_indent(opt : SassOptions*) : UInt8*
  fun sass_option_get_linefeed(opt : SassOptions*) : UInt8*
  fun sass_option_get_input_path(opt : SassOptions*) : UInt8*?
  fun sass_option_get_output_path(opt : SassOptions*) : UInt8*?
  fun sass_option_get_plugin_path(opt : SassOptions*) : UInt8*?
  fun sass_option_get_include_path(opt : SassOptions*) : UInt8*?
  fun sass_option_get_source_map_file(opt : SassOptions*) : UInt8*?
  fun sass_option_get_source_map_root(opt : SassOptions*) : UInt8*?
  fun sass_option_get_c_headers(opt : SassOptions*)
  fun sass_option_get_c_importers(opt : SassOptions*)
  fun sass_option_get_c_functions(opt : SassOptions*)

  # Messages
  fun sass_context_get_output_string(ctx : SassContext*) : UInt8*
  fun sass_context_get_error_status(ctx : SassContext*) : Int32
  fun sass_context_get_error_message(ctx : SassContext*) : UInt8*

  # Release
  fun sass_delete_data_context(ctx : SassDataContext*) : Void
  fun sass_delete_file_context(ctx : SassFileContext*) : Void

  # Sass2Scss
  fun sass2scss_version : UInt8*
  fun sass2scss(sass : UInt8*, options : Int32) : UInt8*
end
