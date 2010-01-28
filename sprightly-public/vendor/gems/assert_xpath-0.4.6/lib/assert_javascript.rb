require 'assert_xpath'
require 'tempfile'
require 'cgi'

#  These assertions soak in Javascript::PurePerl goodness

#:stopdoc:
#  ERGO  this module should use search
#  ERGO  assert_javascript should only use assert_rexml not assert_xml
#  ERGO  tell crew to set eblogs' background color correctly...
#  ERGO  return value on each method
#  ERGO  assert_js_remote_function should take url_for args
    #  ERGO  move got_pure_perl? rdoc to AssertJavaScript page
#  ERGO  clicking in Konsole navigates in Kate
  #  ERGO  any matcher in an assert_js should search
#:startdoc:

def temporarily(obj, member, new_value)
  old_value = obj.send(member)

  begin
    obj.send(member.to_s+'=', new_value)  #  CONSIDER  look up the assign thinger?
    yield
  ensure
    obj.send(member.to_s+'=', old_value)
  end
end  #  ERGO  document!

=begin rdoc
  See: http://assertxpath.rubyforge.org/
%html <pre>
        #\    #.:#                   +------------------------------------------+
         #\  #.:#      ^^^^^     ___/  these assertions use Javascript::PurePerl  \
          #\ #.:#      }OvO{    <___   to convert JS into XML. assert_xpath can   |
           ##.:#      {|   |}       |  query this to find important details,      |
            #..#      \|   |/       \  and safely skip over unimportant details!  /
            #..#       \ _ /         +------------------------------------------+
            #..#        | |
            #..#>=======d=b=======
            #..#
%html </pre>
=end

module AssertJavaScript
  include AssertXPath

  # %html <a name='assert_javascript'></a>
  # Wraps <tt>Javascript::PurePerl</tt> to convert JavaScript into XML describing 
  # each lexeme. This allows subsequent +assert_xpath+ calls to read the JavaScript.
  #
  # See {Javascript::PurePerl for Ruby Enthusiasts}[http://phlip.eblogs.com/2007/07/28/javascriptpureperl-for-ruby-enthusiasts/] 
  # to learn to install Javascript::PurePerl
  # * +source+ - optional string containing JavaScript. The default is 
  #   <tt>@response.body</tt>
  # * +diagnostic+ - optional string to add to failure message
  # Other +assert_js_+* methods call +assert_javascript+ if the secret 
  # <tt>@xdoc</tt> instance variable is +nil+
  #
  # To extract JS from an XHTML page, place the +assert_js+ inside the +assert_xpath+
  # which located your JavaScript. For example:
  #   assert_xpath './/input[ @type = "image" ]' do |input|
  #     assert_javascript input.onclick
  #     assert_xpath './/Statement[2]' do
  #       assert_js_remote_function '/user/inventory/' do 
  #         json = assert_js_argument(2)
  #         path, query = assert_uri('path?' + json[:parameters])
  #         assert_equal @user.id.to_s, query[:user_id]
  #         assert_equal @user.inventory.first.id.to_s, query[:inventory_id]
  #       end
  #     end
  #   end
  #   assert_tag_id :div, :inventory_bar  #  <-- applies to original XML
  #
  # See: AssertJavaScriptTest#test_assert_javascript
  #
  def assert_javascript(source = nil, diagnostic = nil)
    javascript_to_xml(source, diagnostic) do |tmp_error|
      @xdoc = assert_xpath(
                '/AST/Program/SourceElements',
                build_message(
                  diagnostic,
                  "JavaScript <#{source}> contained errors:\n#{File.read(tmp_error) rescue nil}"
                )
              )
    end  #  ERGO  if any diagnostic is a lambda, lazily evaluate it
  end
  alias assert_js assert_javascript

  def assert_javascript_too(&block) #:nodoc:  #  ERGO  merge with assert_javascript!!!
    @xdoc or assert_javascript
    
    sit_and_spin = './/VariableDeclaration/' +
                   'Identifier[ @name = "Identifier" ]/../' +
                   'Initializer[ @name = "Initializer" ]/' +
                   'Number[ @name = "AssignmentExpression" ]/../..'
    stuff = {}

    @xdoc.each_element(sit_and_spin) do |node|
      name = node.get_path('.//Identifier').text
      number = node.get_path('.//Number').text
      stuff[name.to_sym] = number.to_f
      #  ERGO  is to_f best?
      #  ERGO  simpler way to add an ostruct member?
      #  ERGO  cleaner XPath...
    end

    js = OpenStruct.new(stuff)
    block.call(js)
  end

#  ERGO  what is "id('content')/div[1]/" ? Can we do that?
#  ERGO  "put the subtle to the metal..."

  # Negates +assert_javascript+. Inexplicably passes if a string does not contain
  # anything which satisfies <tt>Javascript::PurePerl</tt>'s narrow definition of
  # JavaScript. Depends on +assert_javascript+
  #
  # * +source+ - optional string that should not contain JavaScript. The default is @response.body
  # * +diagnostic+ - optional string to add to failure message
  #
  # Note that "var = 2" will pass, (and fail in +assert_javascript+)
  # because <tt>Javascript::PurePerl</tt> requires a trailing <tt>;</tt> 
  #
  # Example:
  # The author would be interested to hear if anyone finds a use for this
  #
  def deny_javascript(source = nil, diagnostic = nil)
    javascript_to_xml(source, diagnostic) do
      stash_xdoc do 
        deny_xpath( '/AST/Program/SourceElements',
                    build_message(
                      diagnostic,
                      "string <#{_esc source}> should not be well-formed JavaScript"
                   )
                )
      end
    end
  end
  alias deny_js deny_javascript

  unless respond_to? :returning
    def returning(value) #:nodoc:
      yield(value)
      return value
    end
  end

#  ERGO "if that Congress still can't budge
#        daddy's in tight with a Supreme Court judge"

  # %html <a name='assert_json'></a>
  # Converts a REXML::Element into a Hash containing named elements. Currently 
  # we only support Booleans or Strings
  #
  # This depend on methods like assert_js_argument to locate a JSON argument.
  # Otherwise, the method searches for the first JSON it finds in
  # the current context
  # * +jsonic+ - the input REXML::Element node - defaults to the secret <tt>@xdoc</tt>
  #   variable set by +assert_javascript+.
  #
  # Example:
  #
  # %transclude AssertJavaScriptTest#test_assert_json
  #
  def assert_json(jsonic = @xdoc || assert_javascript, diagnostic = nil)
    @xdoc or assert_javascript

    returning Hash.new do |json|
      stash_xdoc do
        @xdoc = jsonic
        assert_any_xpath 'descendant-or-self::PropertyNameAndValueList/PropertyPair', diagnostic
      end  #  ERGO  use assert_any_xpath

      jsonic.each_element('descendant-or-self::PropertyNameAndValueList/PropertyPair') do |node|
        name = node.get_path('PropertyName/*')
        name = name.text.to_sym

        json[name] =
          case
            when b = node.get_path('ObjectLiteral/PropertyNameAndValueList')
              assert_json(b)

            when b = node.get_path('Boolean')
              b.text == '1'

            when b = node.get_path('Number')
              b.text

#  ERGO  how to do an or in an XPath??

            when b = node.get_path('String')
              b.text

            when b = node.get_path('Identifier')
              b.text  #  ERGO  test me!

            when b = node.get_path('ArrayLiteral/ElementList')
              #  ERGO  recurse here
              returning [] do |list|
                b.each_element('*') do |item|
                  list << item.text  #  ERGO  more accurate
                end
              end

            else
            #  ERGO  handle embedded JS expressons!
#puts indent_xml(node)
 # ERGO             flunk "Add type #{node.children.last.name} to assert_json!"
          end
      end
    end
  end

  # Explores a function call's argument list
  # * +index+ - 1-based index into the arguments
  # * +diagnostic+ - optional string to add to failure message
  #
  # Example: AssertJavaScriptTest#test_assert_js_argument
  #
  def assert_js_argument(index = 1, diagnostic = nil)
    @xdoc or assert_javascript
  #  ERGO rdoc: what do we depend on?
    #  ERGO  propagate xpathic 'descendant-or-self'

    assert_xpath xpath_argument(index), diagnostic do |node|
      return node.text if %w(String Identifier).include?(node.name)
      return assert_json if node.name == 'ObjectLiteral'
    end  #  ERGO  test we slip not into a nested argument list
  end

  def deny_js_argument(index = 1, diagnostic = nil)
    @xdoc or assert_javascript
  #  ERGO rdoc: what do we depend on?
    deny_xpath xpath_argument(index), diagnostic
  end

  # Not ready for public use yet!
  #
  def assert_uri(uri)
    path, query = uri.split('?')
    params = {}

    if query
      splitter = using(:libxml?) ? '&amp;' : '&'
      query.split(splitter).each do |item|
        key, value = item.split('=')
        params[key.to_sym] = CGI::unescape(value || '')
      end
    end

    return [path, params]
  end  #  ERGO  get this working on incomplete URLs

#  ERGO  sick local tests for all this stuff that the MMORPG tests
#  ERGO  links out to all this stuff
#  ERGO  tag_id -> element_id

  # Detect the JavaScriptGenerator method +replace_html+
  # * +element_id+ - first argument to +replace_html+ - 
  #   the target HTML Element's +id+
  # * +matcher+ - optional regular expression to match 
  #   the raw contents of the second argument to +replace_html+
  # * +diagnostic+ - optional string to add to failure message
  # * +block+ - optional; permits +assert_xpath+ calls
  # into the HTML contents of the replacement
  #
  # Example: AssertJavaScriptTest#test_assert_js_replace_html
  #
  def assert_js_replace_html(element_id, matcher = nil, diagnostic = nil, &block)
    assert_xpath object_method_xpath('Element', 'update', element_id), diagnostic do
      assert_equal element_id.to_s, assert_js_argument(1)
      assert_match matcher, assert_js_argument(2), diagnostic  if matcher
#  ERGO  fetch argument 2 as yielded xml and match its inner text
      if block
        assert_js_xml(assert_js_argument(2))  #  ERGO do this even without the if
        block.call
      end
    end
  end

  # Negates assert_js_replace_html
  # * +element_id+ - first argument to +replace_html+ - 
  #   the target HTML Element's +id+
  # * +matcher+ - optional regular expression to not match 
  #   the raw contents of the second argument to +replace_html+
  # * +diagnostic+ - optional string to add to failure message
  # If the +matcher+ is +nil+ or not provided, the +element_id+
  # must /not/ match any +Element.update+ call in its context.
  # If the +matcher+ /is/ provided, the +element_id+ /must/
  # match, and the +matcher+ must /not/ agree with its contents
  #
  # Example: AssertJavaScriptTest#test_deny_js_replace_html
  #
  def deny_js_replace_html(element_id, matcher = nil, diagnostic = nil)
    path = object_method_xpath('Element', 'update', element_id)

  #  ERGO  don't let subsequent updates with the same element_id confuse the matcher!

    if matcher and node = @xdoc.get_path(path)
      stash_xdoc do
        @xdoc = node
        assert_no_match matcher, assert_js_argument(2), diagnostic
        return  #  ERGO  pass node for 1st arg to assert_js_argument
      end
    end

    deny_xpath path, diagnostic
  end

  #  ERGO  this line should not crash on bad page:
  # yar = YarWiki.new(params[:id].to_s)  
  #  ERGO  provide link for Flash if you have none
  
  # Detects an Insertion attack.
  # * +orientation+ - <tt>:top</tt>, <tt>:bottom</tt>, etc...
  # Remaining arguments similar to assert_js_replace_html
  #
  # Example:
  # %transclude AssertJavaScriptTest#test_assert_js_insert_html
  #
  def assert_js_insert_html(orientation, element_id, matcher = //, diagnostic = nil)
    orientation = orientation.to_s.capitalize
    
      #  ERGO  the matcher should work the same as assert_js_replace_html
      
    assert_any_xpath object_method_xpath('Insertion', orientation, element_id), matcher, diagnostic do
      assert_equal element_id.to_s, assert_js_argument(1), diagnostic  #  note: shouldn't happen!
      assert_js_xml(assert_js_argument(2))  #  ERGO  good error diagnostic if _this_ fails!
      yield  if block_given?  #  ERGO  yield something?
      return @xdoc  #   ERGO  everyone should return their guts like this
    end
  end  #  ERGO  local test for me
  
  # Detects an +Ajax.Update+ or +Ajax.Request+ call
  # * +action+ - optional - the HTTP Post action - the first 
  #   argument to +Ajax.Update+ or +Ajax.Request+
  # * +tag_id+ - any of the following
  # * - <tt>:request</tt> - 
  # * - <tt>:update</tt> - 
  # * +diagnostic+ - optional string to add to failure message
  #
  # Example:
  #
  def assert_js_remote_function( action = nil, 
                                 tag_id = nil, 
                                 diagnostic = nil )
    matcher = //  #  ERGO
        
    method = if tag_id.class === String or
                tag_id.class == Regexp  #  ERGO  test regexp
               'Update'
             elsif tag_id == :request  #  ERGO  test this branch
               'Request'
             elsif tag_id == :update  #  ERGO  test this branch
               'Update'
             else
               "Request' or . = 'Update"
             end

    xpath = object_method_xpath('Ajax', method, action)

    #  ERGO  search via tag_id!!!

    assert_any_xpath xpath, //, diagnostic do
      if (tag_id.class != String and tag_id.class != Regexp) or
          /#{tag_id}/ =~ assert_js_argument(2)
        if action
        
        #  ERGO  move those GCI::unescapeHTMLs up the food chain?
        
          assert_equal CGI::unescapeHTML(action),
                       CGI::unescapeHTML(assert_js_argument(1)),
                       diagnostic
        end
        #  ERGO  a better system to extract GET parameters
        yield if block_given?  #  ERGO  test this block
        return @xdoc  #  ERGO  test that return
      end
    end  #  ERGO  less confusing error diagnostic if this fails

    flunk build_message(diagnostic, "expected id <#{tag_id}>")
  end

  #  ERGO  test via a javascript-like dsl:
  #   assert_javascript do
  #     js_if, js_replace_html, etc...
  #     var(:x) = 42
  #     object(:Render).update :div_name etc.
  #   end

#  ERGO  diagnostic

  # Not ready for public use!
  #
  def assert_js_xml(q)  #  ERGO explain this beast; hide inside assert_js_*
  
  #  FIXME test this with an &entity;!
  
    xml = eval('"' + q + '"')
    xml = '<html><body>' + CGI::unescapeHTML(xml) + '</body></html>'  if using :libxml?

    assert_xml xml  #  ERGO  what are the errors if these fail?
  end  #  ERGO  test the error recoverer in assert_xml
 
  # Not ready for public use!
  #
  # Example:
  #
  def assert_js_call(*args, &block)
    path, arg1, arg2, diagnostic = *calling_js_path(args)
    assert_xpath path, diagnostic, &block
  end  #  ERGO  local tests for all these

  #
  # * ++ - 
  # * +diagnostic+ - optional string to add to failure message
  #
  # Example:
  #
  def deny_js_call(*args)
    path, arg1, arg2, diagnostic = calling_js_path(args)
    #  ERGO  do something with arg1 and arg2
    deny_xpath path, diagnostic
  end

  # %html <a name='assert_js_show'></a>
  # Detects the Element.show or Element.hide commands
  # * +element_id+ - HTML Element +id+ to target
  # * +visibility+ - defaults to :show; optionally :hide
  #
  def assert_js_show(element_id, visibility = :show)  #  ERGO  also deny, also diagnostic
    assert_xpath object_method_xpath(:Element, visibility, element_id) do
      assert_equal element_id.to_s, assert_js_argument(1)
    end
    #  ERGO  what if the visibility is wrong?
  end  #  ERGO  deny for every assert

  # Alias for assert_js_show(element_id, :hide)
  #
  def assert_js_hide(element_id) assert_js_show(element_id, :hide) end

  # Find a JavaScript if statement, or one of its elements
  # * +*args+ - ERGO!
  # * +diagnostic+ - optional string to add to failure message
  #
  # Example:
  #
  def assert_js_if(*args, &block)
    return assert_any_xpath(*_re_arg_if(*args), &block)
  end
  
  # Fails if a JavaScript +if+ expression or block has the given characteristics
  # * +*args+ - ERGO!
  # * +diagnostic+ - optional string to add to failure message
  #
  # Example:
  #
  def deny_js_if(condition = :all, matcher = nil, diagnostic = nil)
    xpath, matcher, diagnostic = _re_arg_if(condition, matcher, diagnostic)
    return deny_xpath(xpath, diagnostic) unless matcher
    return deny_any_xpath(xpath, matcher, diagnostic)
    #  ERGO  flunk here - with param explanation (if humanly possible!)
  end  #  ERGO  assert_any_xpath should take an explicit block

#  ERGO  extract-method the x[@name=y] stuff!

  #  ERGO  test nesting if statements to require this temporarily
  #  ERGO  rdoc should provide external-able links for important methods

  private  #  ERGO assert_js.js_like_ruby_statements_as_dsl

    def javascript_to_xml(source, diagnostic)
      source   ||= default_js_source(diagnostic)
      source = source.to_s
      source.gsub!('<![CDATA[>', '')
      source.gsub!('<![CDATA[', '')
      source.gsub!('//]]]]>', '')
      source.gsub!(']]>', '')   #  ERGO  fix these things at their source

      here = File.dirname(__FILE__)
      jsToXml_pl = File.join(here, 'jsToXml.pl')

      Tempfile.open('assert_javascript_sample') do |sample|
        Tempfile.open('assert_javascript_error') do |error|
          sample.write(source)
          sample.flush
          got = `perl "#{jsToXml_pl}" "#{sample.path}" 2>#{error.path}`
          assert_xml got
          yield(error.path)
        end
      end
    end  #  ERGO  use @xdoc = assert_xpath in certain other places

    def default_js_source(diagnostic = nil)
      @response.respond_to?(:body)    || flunk(build_message(diagnostic, "no @response.body found - use assert_js(my_js)"))
      return @response.body.relevance || flunk(build_message(diagnostic, "no JavaScript found in @response.body"))
    end  #  ERGO  publish relevance

  #  CONSIDER  permit symbols for both element_id and matcher

    def _re_arg_if(condition = :all, matcher = nil, diagnostic = nil)
      @xdoc or assert_javascript

      matcher = condition.respond_to?(:match) ? condition : matcher
      aspect = :all
      aspect = condition if [:condition, :all, :true, :false].include?(condition)

      xpath = './/IfStatement[ @name = "IfStatement" ]' +
        if aspect == :condition 
          '/Expression[ @name = "Expression" ]' 
        elsif aspect == :all  
          '/..'  #  CONSIDER  why is this here?? 
        else
          "/Statement[ @name='#{aspect}' ]"
        end

      #  ERGO  flunk here - with param explanation (if humanly possible!)

      return [xpath, matcher, diagnostic]
    end
  
    def yield_xdoc_block(xdoc, aspect, matcher, diagnostic, &block)
      @if_condition = @xdoc.parent.parent  if aspect == :condition
      yield(@xdoc = xdoc) if block_given?
      assert_match matcher, @xdoc.inner_text, diagnostic  if matcher
      return @xdoc
    end  #  ERGO  better name and/or tighter abstraction
 
    def xpath_argument(index)
      return "descendant-or-self::ArgumentList/*[position() = #{index}]"
    end
 
  #  ERGO  patch test:recent to run tests with same names as
  #       edited code - hook SVN diff to do it!

    def object_method_xpath(object, method, element_id)
      @xdoc or assert_javascript
      #  ERGO: element_id may be nil. Propagate this
      #  ERGO: element_id -> first_argument
    
      return ".//ArgumentList[ @name = 'Arguments' ]/" +
            (element_id ? "String[ . = '#{element_id}' ]/../" : '') +
             '../' + member_expression(object, method)
    end  #  ERGO  quanti-friably

    def member_expression(object, method)
      return "MemberMemberExpression[ @name = 'Callee' or 
                    @name = 'ClassExpression' ]" + #  ERGO  productively reconcile them two
               "/Identifier[ position() = 1 and 
                             @name = 'lhs' and 
                             . = '#{ object }' ]" +
               "/../Identifier[ position() = 2 and 
                                @name = 'member' and 
                                . = '#{ method }' ]" +
               "/../../ArgumentList[ @name = 'Arguments' ]"
    end

    def calling_js_path(args)
      @xdoc or assert_javascript
      object, method = args.first.to_s.split('.')
      element_id, diagnostic = [args[1], args[2]]
    
      #  ERGO  this should also work without element_id
      #  ERGO  local test that this calls its blocks correctly
    
      if object and method and element_id
        return object_method_xpath(object, method, element_id), *args
      elsif object and method  #  ERGO  document - pass nil for element_id if you need a diagnostic
        #  ERGO  descendent or self?
        return './/' + member_expression(object, method), *args
      else
        return ".//Identifier[ @name = 'Callee' and . = '#{args.shift}' ]" +
                        '/following-sibling::ArgumentList', *args
      end
    end

end

#  ERGO: Don't put all your eggs in one basket before they're hatched.

  # Detect if your kit is complete, and detect if you have <tt>Javascript::PurePerl</tt>.
  # If you don't, we warn one time. Use this method to defend portable tests that
  # should not break on computers without Javascript::PurePerl
  #
  # Example:
  #  if RAILS_ENV == 'test' and got_pure_perl?
  #    class AssertJavaScriptTest < Test::Unit::TestCase
  #      # ...
  #    end
  #  end
  #
def got_pure_perl?
  perl_version = `perl -v 2>&1` rescue 'perl, v0'
  perl_version =~ /perl, v(\d+)/

  if $1.to_i < 5
    puts "\ninsufficient Perl for assert_js!" unless $already_warned_about_missing_pure_perl
    $already_warned_about_missing_pure_perl = true
    return false
  end

  unless system('perl -e "use Javascript::PurePerl" 2>/dev/null')
    puts "\ninstall Javascript::PurePerl for best results!" unless $already_warned_about_missing_pure_perl
    $already_warned_about_missing_pure_perl = true
    return false
  end

  return true
end
