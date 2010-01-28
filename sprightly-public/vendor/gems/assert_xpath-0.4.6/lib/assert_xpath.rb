require 'rexml/document'
require 'stringio'
require 'rubygems'
require 'libxml'  #  FIXME  soften that requirement!
require 'xml'

RAILS_ENV = ENV.fetch('RAILS_ENV', 'test') unless defined?(RAILS_ENV)
AFE = Test::Unit::AssertionFailedError unless defined?(AFE)

=begin
#:stopdoc:
# "We had so much fun robbing the bank we forgot to take the money"
#
#  ERGO comic book: programmers hunting bugs portrayed as big game hunters in jungle

    #  ERGO  use length not size

#  ERGO  complain to ZenTest forum that
#        assert_in_epsilon should not blot out
#        its internal message if you add an external one
    - test_zentest_assertions should use assert_raise_message
    - we should use assert_include more
    - use util_capture more!
    - use Test::Rails::ControllerTestCase & HelperTestCase
    - use all the assertions in ViewTest (and compete!)
    - tell ZT their view assertions should nest
    - take target name out of render calls if the test case name is correct!
      - use path_parameters to override
    - use the LayoutsController dummy object trick!
    - use named routes more!

#  ERGO  learn FormEncodedPairParser
#  ERGO RDoc a blog entry
#  ERGO  write deny_match, and make it work correctly!!
#  ERGO link from Hpricot references to real Hpricot verbiage
#  ERGO  <tt> -> <code> in RDoc!!
#  ERGO  assert_xpath is nothing but a call to assert_any_xpath
#  ERGO  two %transclude directives in a row should work
#  ERGO  document, redundantly, that @xdoc always has bequeathed_attributes
#  ERGO  complain to RDoc maintainers that {}[] targets the current frame!
#              monkey-patch thereof
#  ERGO  link out to REXML::Element
#  ERGO  how to RDoc format the sample for indent_xml etc?
#  ERGO  how to syntax hilite the sample for indent_xml etc?
#  ERGO  cross links in sample code
#  ERGO  back RDoc with complete source
#  ERGO  links from RDoc file reports in their contents
#  ERGO  is search{} defined in terms of assert_any_xpath??
#  ERGO  get Hpricot::search going for self-or-descendent, and take out all Hpricot::Doc cruft!
#  ERGO  does Hpricot#Doc[] or #Elem[] conflict with anything?
#  ERGO  merge the common bequeathed attributes into one module
  #  indent_xml should find a system built-into Hpricot?
#:startdoc:
=end


=begin rdoc
See: http://assertxpath.rubyforge.org/

%html <pre>
                        ___________________________
    #                __/   >tok tok tok<           \
    #< <%<          <__  assert_xpath reads XHTML  |
    #   (\\=           |  and queries its details! |
    #    |              ---------------------------
    #===={===
    #
%html </pre>

=end


module AssertXPath

  module CommonXPathExtensions #:nodoc:

    def symbolic?(index)
      return index.to_s  if (index.kind_of? String or index.kind_of? Symbol)
    end

    def[](index)
      if symbol = symbolic?(index)
        return attributes[symbol]  if attributes.has_key? symbol
        raise_magic_member_not_found(symbol, caller)
      end

      return super  #  ERGO  test this works?
    end

    def raise_magic_member_not_found(symbol, whats_caller_ERGO)
      raise AFE,  #  ERGO  merge with other raiser(s)
            "missing attribute: `#{symbol}` in " +
              "<#{ name } #{ attributes.keys.join(' ') }>",
            whats_caller_ERGO
    end

    def identifiable?(str)  #  ERGO  self. ?
      return str =~ /^ [[:alpha:]] [[:alnum:]_]* $/ix
    end  #  ERGO  simplify??

#  ERGO  mock the YarWiki and run its tests locally!!!

    def tribute(block)
      stash = {}  # put back the ones we changed!

      if block
        varz = instance_variables

        attributes.each do |key, value|
          if identifiable?(key)  #  deal if the key ain't a valid variable
            key = "@#{ key }"
            stash[key] = instance_variable_get(key)  if varz.include?(key)
#p stash[key]
            instance_variable_set key, value
          end
        end

        return instance_eval(&block)
      end
    ensure  #  put them back!
      stash.each{|key, value|  instance_variable_set(key, value)  }
    end  #  this utterly sick convenience helps Ruby {@id} look like XPathic [@id]

  end

    #  ERGO  document me
  def drill(&block)
    if block
          #  ERGO  harmonize with bang! version
        #  ERGO  deal if the key ain't a valid variable

      unless tribute(block)  #  ERGO  pass in self (node)?
        sib = self
        nil while (sib = sib.next_sibling) and sib.node_type != :element
p sib #  ERGO  do tests ever get here?
        q = sib and _bequeath_attributes(sib).drill(&block)
        return sib  if q
        raise Test::Unit::AssertionFailedError.new("can't find beyond <#{xpath}>")
      end
    end

    return self
    #  ERGO  if block returns false/nil, find siblings until it passes.
    #        throw a test failure if it don't.
    #  ERGO  axis concept
  end

end

  #  ERGO  node.descendant{ @type == 'text' and @id == 'foo' }.value
  #  ERGO  node..a_descendant - overload ..

def _bequeath_attributes(node)  #:nodoc:
  return node  if node.kind_of?(::Hpricot::Elem) or node.kind_of?(::Hpricot::Doc)
    #  ERGO  shouldn't this be in a stinkin' module??
    #  ERGO  SIMPLER!!
    #  ERGO  document me
  def node.drill(&block)
    if block
        #  ERGO  harmonize with bang! version
        #  ERGO  deal if the key ain't a valid variable

      unless tribute(block)  #  ERGO  pass in self (node)?
        sib = self
        nil while (sib = sib.next_sibling) and sib.node_type != :element
        q = sib and _bequeath_attributes(sib).drill(&block)
        return sib  if q
        raise Test::Unit::AssertionFailedError.new("can't find beyond <#{ xpath }>")
      end
    end

    return self
    #  ERGO  if block returns false/nil, find siblings until it passes.
    #        throw a test failure if it don't.
    #  ERGO  axis concept
  end

  return node  #  ERGO  use this return value
end  #  ERGO  is _ a good RPP for a "pretend private"?


module AssertXPath

  Element = ::REXML::Element unless defined?(Element) #:nodoc:

  class XmlHelper #:nodoc:
    def libxml? ;  false end  #  this is not a 'downcast' (bad in OO)
    def rexml? ;   false end  #  becase diverse libraries are a "boundary"
    def hpricot? ; false end  #  situation. We can't control their contents!
  end

  class HpricotHelper < XmlHelper  #:nodoc:
    def hpricot? ;  true  end
    def symbol_to_xpath(tag)  tag.to_s  end
    def assert_xml(suite, *args, &block)
      return suite.assert_hpricot(*args, &block)
    end
  end

  class LibxmlHelper < XmlHelper  #:nodoc:
    def libxml? ;  true  end
    def symbol_to_xpath(tag)  "descendant-or-self::#{tag}"  end
    def assert_xml(suite, *args, &block)
      return suite.assert_libxml(*args, &block)
    end
  end

  class RexmlHelper < XmlHelper #:nodoc:
    def rexml? ;   true  end
    def symbol_to_xpath(tag)  ".//#{tag}"  end
    def assert_xml(suite, *args, &block)
      return suite.assert_rexml(*args, &block)
    end
  end

  # Subsequent +assert_xml+ calls will use
  # Hpricot[http://code.whytheluckystiff.net/hpricot/].
  # (Alternately,
  # +assert_hpricot+ will run one assertion in Hpricot mode.)
  # Put +invoke_hpricot+ into +setup+() method, to
  # run entire suites in this mode. These test cases
  # explore some differences between the two assertion systems:
  # %transclude AssertXPathSuite#test_assert_long_xpath
  #
  def invoke_hpricot
    @xdoc = nil
    @helper = HpricotHelper.new
  end

  # Subsequent +assert_xml+ calls will use
  # LibXML[http://libxml.rubyforge.org/].
  # (Alternately,
  # +assert_libxml+ will run one assertion in Hpricot mode.)
  # Put +invoke_libxml+ into +setup+() method, to
  # run entire suites in this mode.
  #
  def invoke_libxml(favorite_flavor = :html)
    @_favorite_flavor = favorite_flavor
    @xdoc   = nil
    @helper = LibxmlHelper.new
  end

  def _doc_type  #  ERGO  document all these!
    { :html => '<!DOCTYPE HTML PUBLIC ' +
               '"-//W3C//DTD HTML 4.01 Transitional//EN" '+
               '"http://www.w3.org/TR/html4/loose.dtd">',
      :xhtml => '<!DOCTYPE html PUBLIC ' +
                '"-//W3C//DTD XHTML 1.0 Transitional//EN" ' +
                '"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" >',
      :xml => nil
               }.freeze
  end
  private :_doc_type

  #  ERGO  what happens to assert_js_replace_html bearing entities??

  # Subsequent +assert_xml+ calls will use REXML. See
  # +invoke_hpricot+ to learn the various differences between the
  # two systems
  def invoke_rexml
    @xdoc   = nil
    @helper = RexmlHelper.new
  end

  # %html <a name='assert_xml'></a>
  #
  # Prepare XML for assert_xpath <em>et al</em>
  # * +xml+ - optional string containing XML. Without it, we read <code>@response.body</code>
  # * <code>xpath, diagnostic, block</code> - optional arguments passed to +assert_xpath+
  # Sets and returns the new secret <code>@xdoc</code> REXML::Element root
  # call-seq:
  #   assert_xml(xml = @response.body <em>[, assert_xpath arguments]</em>) -> @xdoc, or assert_xpath's return value
  #
  # Assertions based on +assert_xpath+ will call this automatically if
  # the secret <code>@xdoc</code> is +nil+. This implies we may freely call
  # +assert_xpath+ after any method that populates <code>@response.body</code>
  # -- if <code>@xdoc</code> is +nil+. When in doubt, call +assert_xml+ explicitly
  #
  # +assert_xml+ also translates the contents of +assert_select+ nodes. Use this to
  # bridge assertions from one system to another. For example:
  #
  # Returns the first node in the XML
  #
  # Examples:
  #   assert_select 'div#home_page' do |home_page|
  #     assert_xml home_page  #  <-- calls home_page.to_s
  #     assert_xpath ".//img[ @src = '#{newb.image_uri(self)}' ]"
  #     deny_tag_id :form, :edit_user
  #   end
  #
  # %transclude AssertXPathSuite#test_assert_long_sick_expression
  # See: AssertXPathSuite#test_assert_xml_drill
  #
  def assert_xml(*args, &block)
    using :libxml? # prop-ulates @helper
    return @helper.assert_xml(self, *args, &block)
  end  #  ERGO  take out the rescue nil!, and pass the diagnostic thru

  # Processes a string of text, or the hidden <code>@response.body</code>,
  # using REXML, and sets the hidden <code>@xdoc</code> node. Does
  # not depend on, or change, the values of +invoke_hpricot+, +invoke_libxml+,
  # or +invoke_rexml+
  #
  # Example:
  # %transclude AssertXPathSuite#test_assert_rexml
  #
  def assert_rexml(*args, &block)
    contents = (args.shift || @response.body).to_s
#  ERGO  benchmark these things

    contents.gsub!('\\\'', '&apos;')
    contents.gsub!('//<![CDATA[<![CDATA[', '')
    contents.gsub!('//<![CDATA[', '')
    contents.gsub!('//]]>', '')
    contents.gsub!('//]>', '')
    contents.gsub!('//]]', '')
    contents.gsub!('//]', '')

    begin
      @xdoc = REXML::Document.new(contents)
    rescue REXML::ParseException => e
      raise e  unless e.message =~ /attempted adding second root element to document/
      @xdoc = REXML::Document.new("<xhtml>#{ contents }</xhtml>")
    end

    _bequeath_attributes(@xdoc)
    assert_xpath(*args, &block)  if args != []
    return (assert_xpath('/*') rescue nil)  if @xdoc
  end

  #  Temporarily sets the validation type to :xml, :html, or :xhtml
  #
  def validate_as(type) # FIXME use or lose this
    @_favorite_flavor, formerly = type, @_favorite_flavor
    yield
  ensure
    @_favorite_flavor = type
  end  #  ERGO  more documentation!

  def assert_libxml(*args, &block)
    xml = args.shift || @xdoc || @response.body
    xhtml = xml.to_s

      #  CONSIDER  fix this like at the source??
    xhtml.gsub!('<![CDATA[>', '')
    xhtml.gsub!('<![CDATA[', '')
    xhtml.gsub!('//]]]]>', '')
    xhtml.gsub!(']]>', '')

    if xhtml !~ /^\<\!DOCTYPE\b/ and xhtml !~ /\<\?xml\b/
      xhtml = _doc_type[@_favorite_flavor || :html] + "\n" + xhtml if _doc_type[@_favorite_flavor]
    end  #  ERGO  document we pass HTML level into invoker

    if xhtml.index('<?xml version="1" standalone="yes"?>') == 0
      xhtml.gsub!('<?xml version="1" standalone="yes"?>', '')
      xhtml.strip!  #  ERGO  what is libxml's problem with that line???
    end

    # # FIXME blog that libxml will fully validate your ass...

    xp = xhtml =~ /\<\!DOCTYPE/ ? XML::HTMLParser.new() : XML::Parser.new()
    xhtml = '<xml/>' unless xhtml.any?
    xp.string = xhtml
#  FIXME  blog we don't work with libxml-ruby 3.8.4
#   XML::Parser.default_load_external_dtd = false
    XML::Parser.default_pedantic_parser = false # FIXME optionalize that

#what? xp
    doc = xp.parse
#what? doc
#puts doc.debug_dump
    @xdoc = doc.root
#    @xdoc.namespace ||= XML::NS.new('')

#pp (@xdoc.root.public_methods - public_methods).sort
    return assert_xpath(*args, &block)  if args.length > 0
    return @xdoc
  end

  def using(kode)
    @helper ||= RexmlHelper.new  #  ERGO  escallate this!
    return @helper.send(kode)
  end

  #  FIXME  test that the helper system withstands this effect:
  #   ""

  # %html <a name='assert_hpricot'></a>
  #
  # This parses one XML string using Hpricot, so subsequent
  # calls to +assert_xpath+ will use Hpricot expressions.
  # This method does not depend on +invoke_hpricot+, and
  # subsequent test cases will run in their suite's mode.
  #
  # Example:
  # %transclude AssertXPathSuite#test_assert_hpricot
  #
  # See also: assert_hpricot[http://www.oreillynet.com/onlamp/blog/2007/08/assert_hpricot_1.html]
  #
  def assert_hpricot(*args, &block)
    xml = args.shift || @xdoc || @response.body  ## ERGO why @xdoc??
  #  ERGO  document that callseq!
    require 'hpricot'
    @xdoc = Hpricot(xml.to_s)  #  ERGO  take that to_s out of all callers
    return assert_xpath(*args, &block)  if args.length > 0
    return @xdoc
  end  #  ERGO  reasonable error message if ill-formed

  #  ENCORE  Bus to Julian! (-;
  #  ERGO  why %html <a name='assert_xpath' /> screws up?

  # %html <a name='assert_xpath'></a>
  #
  # Return the first XML node matching a query string. Depends on +assert_xml+
  # to populate our secret internal REXML::Element, <code>@xdoc</code>
  # * +xpath+ - a query string describing a path among XML nodes.
  #   See: {XPath Tutorial Roundup}[http://krow.livejournal.com/523993.html]
  # * +diagnostic+ - optional string to add to failure message
  # * <code>block|node|</code> - optional block containing assertions, based on +assert_xpath+,
  #   which operate on this node as the XPath '.' current +node+
  # Returns the obtained REXML::Element +node+
  #
  # Examples:
  #
  #   render :partial => 'my_partial'
  #
  #   assert_xpath '/table' do |table|
  #     assert_xpath './/p[ @class = "brown_text" ]/a' do |a|
  #       assert_equal user.login,   a.text  # <-- native <code>REXML::Element#text</code> method
  #       assert_match /\/my_name$/, a[:href]  # <-- attribute generated by +assert_xpath+
  #     end
  #     assert_equal "ring_#{ring.id}", table.id!  # <-- attribute generated by +assert_xpath+, escaped with !
  #   end
  #
  # %transclude AssertXPathSuite#test_assert_xpath
  #
  # See: AssertXPathSuite#test_indent_xml,
  # {XPath Checker}[https://addons.mozilla.org/en-US/firefox/addon/1095]
  #
  def assert_xpath(*args, &block)
    return assert_tag_id(*args, &block) if args.length > 1 and args[1].kind_of?(Symbol) or args[1].kind_of?(Hash)
#     return assert_any_xpath(xpath, diagnostic) {
#              block.call(@xdoc) if block
#              true
#            }
    xpath, diagnostic = args
    stash_xdoc do
      xpath = symbol_to_xpath(xpath)
      node  = @xdoc.search(xpath).first
      @xdoc = node || flunk_xpath(diagnostic, "should find xpath <#{_esc xpath}>")
      @xdoc = _bequeath_attributes(@xdoc)
      block.call(@xdoc) if block  #  ERGO  tribute here?
      return @xdoc
    end
  end

#  FIXME assert_js_argument(2)  gotta return nill for nada

  # Negates +assert_xpath+. Depends on +assert_xml+
  #
  # Examples:
  #   assert_tag_id :td, :object_list do
  #     assert_xpath "table[ position() = 1 and @id = 'object_#{object1.id}' ]"
  #     deny_xpath   "table[ position() = 2 and @id = 'object_#{object2.id}' ]"
  #   end  #  find object1 is still displayed, but object2 is not in position 2
  #
  # %transclude AssertXPathSuite#test_deny_xpath
  #
  def deny_xpath(*args)
    return deny_tag_id(*args) if args.length > 1 and args[1].kind_of?(Symbol) or args[1].kind_of?(Hash)
    xpath, diagnostic = args
    @xdoc or assert_xml
    xpath = symbol_to_xpath(xpath)

    @xdoc.search(xpath).first and
      flunk_xpath(diagnostic, "should not find: <#{_esc xpath}>")
  end

  # Search nodes for a matching XPath whose <code>AssertXPath::Element#inner_text</code> matches a Regular Expression. Depends on +assert_xml+
  # * +xpath+ - a query string describing a path among XML nodes.
  #   See: {XPath Tutorial Roundup}[http://krow.livejournal.com/523993.html]
  # * +matcher+ - optional Regular Expression to test node contents
  # * +diagnostic+ - optional string to add to failure message
  # * <code>block|node|</code> - optional block called once per match.
  #   If this block returns a value other than +false+ or +nil+,
  #   assert_any_xpath stops looping and returns the current +node+
  #
  # Example:
  # %transclude AssertXPathSuite#test_assert_any_xpath
  #
  def assert_any_xpath(xpath, matcher = nil, diagnostic = nil, &block)
    matcher ||= //
    block   ||= lambda{ true }
    found_any = false
    found_match = false
    xpath = symbol_to_xpath(xpath)

    stash_xdoc do
      #assert_xpath xpath, diagnostic

      if !using(:rexml?)
        @xdoc.search(xpath) do |@xdoc|
          found_any = true

          if @xdoc.inner_text =~ matcher
            found_match = true
            _bequeath_attributes(@xdoc)
            return @xdoc  if block.call(@xdoc)
            #  note we only exit block if block.nil? or call returns false
          end
        end
      else  # ERGO      merge!
        @xdoc.each_element(xpath) do |@xdoc|
          found_any = true

          if @xdoc.inner_text =~ matcher
            found_match = true
            _bequeath_attributes(@xdoc)
            return @xdoc  if block.call(@xdoc)
            #  note we only exit block if block.nil? or call returns false
          end
        end
      end
    end

    found_any or
      flunk_xpath(diagnostic, "should find xpath <#{_esc xpath}>")

    found_match or
      flunk_xpath(
          diagnostic,
          "can find xpath <#{_esc xpath}> but can't find pattern <?>",
          matcher
          )
  end

  # Negates +assert_any_xpath+. Depends on +assert_xml+
  #
  # * +xpath+ - a query string describing a path among XML nodes. This
  #   must succeed - use +deny_xpath+ for simple queries that must fail
  # * +matcher+ - optional Regular Expression to test node contents. If +xpath+ locates multiple nodes,
  #   this pattern must fail to match each node to pass the assertion.
  # * +diagnostic+ - optional string to add to failure message
  #
  # Contrived example:
  #   assert_xml '<heathrow><terminal>5</terminal><lean>methods</lean></heathrow>'
  #
  #   assert_raise_message Test::Unit::AssertionFailedError,
  #                           /all xpath.*\.\/\/lean.*not have.*methods/ do
  #     deny_any_xpath :lean, /methods/
  #   end
  #
  #   deny_any_xpath :lean, /denver/
  #
  # See: AssertXPathSuite#test_deny_any_xpath,
  # {assert_raise (on Ruby) - Don't Just Say "No"}[http://www.oreillynet.com/onlamp/blog/2007/07/assert_raise_on_ruby_dont_just.html]
  #
  def deny_any_xpath(xpath, matcher, diagnostic = nil)
    @xdoc or assert_xml
    xpath = symbol_to_xpath(xpath)

    assert_any_xpath xpath, nil, diagnostic do |node|
      if node.inner_text =~ matcher
        flunk_xpath(
            diagnostic,
            "all xpath <#{_esc xpath}> nodes should not have pattern <?>",
            matcher
            )
      end
    end
  end

   # FIXME @helper -> @_helper

  # Wraps the common idiom <code>assert_xpath('descendant-or-self::./<em>my_tag</em>[ @id = "<em>my_id</em>" ]')</code>. Depends on +assert_xml+
  # * +tag+ - an XML node name, such as +div+ or +input+.
  #   If this is a <code>:symbol</code>, we prefix "<code>.//</code>"
  # * +id+ - string, symbol, or hash identifying the node. ids must not contain punctuation
  # * +diagnostic+ - optional string to add to failure message
  # * <code>block|node|</code> - optional block containing assertions, based on
  #   +assert_xpath+, which operate on this node as the XPath '.' current node.
  # Returns the obtained REXML::Element +node+
  #
  # Examples:
  #
  #   assert_tag_id '/span/div', "audience_#{ring.id}" do
  #     assert_xpath 'table/tr/td[1]' do |td|
  #       #...
  #       assert_tag_id :form, :for_sale
  #     end
  #   end
  #
  # %transclude AssertXPathSuite#test_assert_tag_id_and_tidy
  #
  # %transclude AssertXPathSuite#test_assert_tag_id
  #
  def assert_tag_id(tag, id = {}, diagnostic = nil, diagnostic2 = nil, &block)
    # if id is not a hash, diagnostic might be a hash too!
  #  CONSIDER  upgrade assert_tag_id to use each_element_with_attribute
    assert_xpath build_xpath(tag, id, diagnostic), diagnostic2 || diagnostic, &block
  end  #  NOTE: ids may not contain ', so we are delimiter-safe

  # Negates +assert_tag_id+. Depends on +assert_xml+
  #
  # Example - see: +assert_xml+
  #
  # See: +assert_tag_id+
  #
  def deny_tag_id(tag, id, diagnostic = nil, diagnostic2 = nil)
    deny_xpath build_xpath(tag, id, diagnostic), diagnostic2 || diagnostic
  end

  # Pretty-print a REXML::Element or Hpricot::Elem
  # * +doc+ - optional element. Defaults to the current +assert_xml+ document
  # returns: string with indented XML
  #
  # Use this while developing a test case, to see what
  # the current <code>@xdoc</code> node contains (as populated by +assert_xml+ and
  # manipulated by +assert_xpath+ <em>et al</em>)
  #
  # For example:
  #    assert_javascript 'if(x == 42) answer_great_question();'
  #
  #    assert_js_if /x.*42/ do
  #      puts indent_xml  #  <-- temporary statement to see what to assert next!
  #    end
  #
  # See: AssertXPathSuite#test_indent_xml
  #
  def indent_xml(doc = @xdoc || assert_xml)
    if doc.kind_of?(Hpricot::Elem) or doc.kind_of?(Hpricot::Doc)
      zdoc = doc
      doc = REXML::Document.new(doc.to_s.strip) rescue nil
      unless doc  #  Hpricot didn't well-formify the HTML!
        return zdoc.to_s  #  note: not indented, but good enough for error messages
      end
    end

# require 'rexml/formatters/default'
# bar = REXML::Formatters::Pretty.new
# out = String.new
# bar.write(doc, out)
# return out

    return doc.to_s  #  ERGO  reconcile with 1.8.6.111!

    x = StringIO.new
    doc.write(x, 2)
    return x.string  #  CONSIDER  does REXML have a simpler way?
  end

  # %html <a name='assert_tidy'></a>
  # Thin wrapper on the Tidy command line program (the one released 2005 September)
  # * +messy+ - optional string containing messy HTML. Defaults to <code>@response.body</code>.
  # * +verbosity+ - optional noise level. Defaults to <code>:noisy</code>, which
  #   reports most errors. :verbose reports all information, and other value
  #   will repress all of Tidy's screams of horror regarding the quality of your HTML.
  # The resulting XHTML loads into +assert_xml+. Use this to retrofit +assert_xpath+ tests
  # to less-than-pristine HTML.
  #
  # +assert_tidy+ obeys +invoke_rexml+ and +invoke_hpricot+, to
  # select its HTML parser
  #
  # Examples:
  #
  #  get :adjust, :id => transaction.id  # <-- fetches ill-formed HTML
  #  assert_tidy @response.body, :quiet  # <-- upgrades it to well-formed
  #  assert_tag_id '//table', :payment_history do  # <-- sees good XML
  #    #...
  #  end
  #
  # %transclude AssertXPathSuite#test_assert_tag_id_and_tidy
  #
  def assert_tidy(messy = @response.body, verbosity = :noisy)
    scratch_html = RAILS_ROOT + '/tmp/scratch.html'
    #  CONSIDER  a railsoid tmp file system?
    #  CONSIDER  yield to something to respond to errors?
    File.open(scratch_html, 'w'){|f|  f.write(messy)  }
    gripes = `tidy -eq #{scratch_html} 2>&1`
    gripes.split("\n")

    #  TODO  kvetch about client_input_channel_req: channel 0 rtype keepalive@openssh.com reply 1

    puts gripes if verbosity == :verbose

    puts gripes.reject{|g|
      g =~ / - Info\: /                                  or
      g =~ /Warning\: missing \<\!DOCTYPE\> declaration/ or
      g =~ /proprietary attribute/                       or
      g =~ /lacks "(summary|alt)" attribute/
    } if verbosity == :noisy

    assert_xml `tidy -wrap 1001 -asxhtml #{ scratch_html } 2>/dev/null`
      #  CONSIDER  that should report serious HTML deformities
  end  #  CONSIDER  how to tidy <% escaped %> eRB code??

  #  FIXME  write a plugin for cruisecontrol.rb
  #            that links metrics to Gruff per project
  #            (and link from assert2.rf.org to rf.org/projects/assert2

  private

  #  ERGO  update documentation of those who use this
    def symbol_to_xpath(tag)
      return tag unless tag.class == Symbol
      @helper or using :libxml? # prop-ulates @helper
      return @helper.symbol_to_xpath(tag)
    end

    def build_xpath(tag, id, diagnostic)
      options = ( case id
                    when Symbol, String ; { :id => id }
                    when Hash           ; id
                  end )

      options.merge!(diagnostic)  if diagnostic.kind_of? Hash

      predicate = options.map{|k,v|
                    if k.kind_of? Symbol
                      "@#{k} = \"#{v}\""
                    else
                      "#{k} = #{v}"
                    end
                  }.join(' and ')

      return symbol_to_xpath(tag) + "[ #{predicate} ]"
    end

    def stash_xdoc
      former_xdoc = @xdoc || assert_xml
      yield  ensure @xdoc = former_xdoc
    end

    def flunk_xpath(diagnostic, template, *args) #:nodoc:
      xml = _esc(indent_xml).relevance || '(@xdoc is blank!)'
      flunk build_message(diagnostic, "#{template} in\n#{xml}", *args)
    end

end


def _esc(x) #:nodoc:
  return x.gsub('?', '\?')
end


#####################################################

#  FIXME  got_libxml?

#  ERGO  hpricot gets its own module (REXML-free!)

def got_hpricot?  #  ERGO  help tests pass without it
  require 'hpricot'
  return true
rescue MissingSourceFile
  return false
end

#####################################################

  #  parking some tiny conveniences here,
  #   where even production code can get to them...
module Relevate
  def relevant?
    return ! blank?
  end

  def relevance
    return to_s  if relevant?
  end
end

#  ERGO  dry these up
class String
    def blank?
        return strip.size == 0
    end
end

class NilClass
    def blank?; true; end
end

#  ERGO  include our test modules like this too
#  ERGO  seek relevant? calls that could use relevance

NilClass.send :include, Relevate
String  .send :include, Relevate

#:enddoc:

# props: http://www.intertwingly.net/blog/2007/11/02/MonkeyPatch-for-Ruby-1-8-6
doc = REXML::Document.new '<doc xmlns="ns"><item name="foo"/></doc>'
if not doc.root.elements["item[@name='foo']"]
  class REXML::Element
    def attribute( name, namespace=nil )
      prefix = nil
      prefix = namespaces.index(namespace) if namespace
      prefix = nil if prefix == 'xmlns'
      attributes.get_attribute( "#{prefix ? prefix + ':' : ''}#{name}" )
    end
  end
end


#  These monkey patches push Hpricot behavior closer to our customized REXML behavior
module Hpricot #:nodoc:
  class Doc #:nodoc:
    include AssertXPath::CommonXPathExtensions

    def [](index) #:nodoc:
      return root[index]  if symbolic? index
      super
    end

    def text
      return root.text
    end

    def method_missing(*args, &block) #:nodoc:
      # if got = search(symbol).first get first descendant working here!
      #  ERGO  call root here
      symbol = args.first.to_s.sub(/\!$/, '')

      root.children.grep(Hpricot::Elem).each do |kid|
        if kid.name == symbol
          return kid.drill(&block)
            #  ERGO  assert on return value
            #  ERGO  pass kid in for if you want it
        end
      end
      # ERGO  raise here?
    end
  end

  class Elem #:nodoc:
    include AssertXPath::CommonXPathExtensions

    def [](index) #:nodoc:
    #  ERGO  do this conflict with anything?
      if symbol = symbolic?(index)
        return attributes[symbol]  if attributes.has_key? symbol
        raise_magic_member_not_found(symbol, caller)
      end

      super
    end

    def text  #  simulate REXML style - fetch child with text
      return (text? ? to_s : '') + children.select(&:text?).map(&:to_s).compact.join
    end

    def node_type
      return :element  #  ERGO  make me less useless
    end

    def drill(&block)
      if block
          #  ERGO  harmonize with bang! version
          #  ERGO  deal if the key ain't a valid variable
          #  ERGO  get method_missing to stop returning []
        unless tribute(block)  #  ERGO  pass in self (node)?
          sib = self
          nil while (sib = sib.next_sibling) and sib.node_type != :element
          q = sib and _bequeath_attributes(sib).drill(&block)
          return sib  if q
          raise Test::Unit::AssertionFailedError.new("can't find beyond <#{_esc xpath}>")
        end
      end

      return self
      #  ERGO  if block returns false/nil, find siblings until it passes.
      #        throw a test failure if it don't.
      #  ERGO  axis concept
    end

    def method_missing(*args, &block) #:nodoc:
      symbol = args.shift.to_s.sub(/\!$/, '')

      children.grep(Hpricot::Elem).each do |kid|
        if kid.name == symbol
          kid.tribute(block)
            #  ERGO  assert on return value
            #  ERGO  pass kid in for if you want it
          return kid
        end
      end

      raise_magic_member_not_found(symbol, caller)  #  ERGO  repurpose!
    end
  end

end


module XML
  class Node  #:nodoc:
    include AssertXPath::CommonXPathExtensions

    def search(xpath, &block)
      if block
        find(xpath, "x:http://www.w3.org/1999/xhtml").each(&block)
        #find(xpath, &block)
      end
      return [find_first(xpath, "x:http://www.w3.org/1999/xhtml")]
    end
    alias each_element search

    def text
      find_first('text()').to_s
    end

    def inner_text(interstitial = '')
      array = []
      self.find( 'descendant-or-self::text()' ).each{|x| array << x }
      return array.join(interstitial)
    end  #  ERGO  match??

#     def attributes
#       hash = {}
#       each_attr{|attr|  hash[attr.name] = attr.value }
#       return hash  #  ERGO  uh, was there a leaner way??
#     end

    def [](index) #:nodoc:
      return attributes[index.to_s] || super
    end

    def get_path(xpath)
      node = find_first(xpath.to_s)
      return _bequeath_attributes(node)  if node
    end  #  ERGO  test that attributes are bequeathed!

    alias :/ get_path

    def method_missing(*args, &block) #:nodoc:
      #  ERGO  use the define_method trick here
      symbol = args.shift.to_s
      symbol.sub!(/\!$/, '')

      kid = if symbol == '/'
        find_first('/')
      else
        find_first("./#{symbol}")
      end
      return _bequeath_attributes(kid).drill(&block)  if kid
      raise_magic_member_not_found(symbol, caller)
    end
  end

end


class REXML::Element
  include AssertXPath::CommonXPathExtensions

  # Semi-private method to match Hpricotic abilities
  def search(xpath)
    return self.each_element( xpath ){}
  end

  def method_missing(*args, &block) #:nodoc:
    symbol = args.shift

    each_element("./#{symbol}") do |kid|
      return _bequeath_attributes(kid).drill(&block)
    end  #  ERGO  element/:child - def/

    raise_magic_member_not_found(symbol, caller)  #  ERGO  repurpose!
  end  #  ERGO  convert attribute chain to xpath

    # Returns all text contents from a node and its descendants
    #
    # Example:
    #
    #  assert_match 'can\'t be blank', assert_tag_id(:div, :errorExplanation).inner_text.strip
    #
    # %transclude AssertXPathSuite#test_inner_text
    #
  def inner_text(interstitial = '')
    return self.each_element( './/text()' ){}.join(interstitial)
  end  #  ERGO  match??

  def get_path(xpath)
    node = each_element(xpath.to_s){}.first
    return _bequeath_attributes(node)  if node
  end  #  ERGO  test that attributes are bequeathed!

  alias :/ get_path

  #  ERGO  use set_backtrace to seat the backtracer to your code
  #  ERGO  move _bequeath stuff in here!
  #  ERGO  phase out the missing_method stuff that adds props

end


# FIXME  hpricot, libxml, rexml always in alpha order

  #  http://www.oreillynet.com/ruby/blog/2008/01/assert_efficient_sql.html
  #  http://www.oreillynet.com/onlamp/blog/2007/09/big_requirements_up_front.html
  #  http://www.oreillynet.com/onlamp/blog/2007/08/assert_hpricot_1.html
  #  http://www.oreillynet.com/onlamp/blog/2007/08/xpath_checker_and_assert_xpath.html
  #  http://phlip.eblogs.com/2007/07/28/javascriptpureperl-for-ruby-enthusiasts/
  #  http://www.oreillynet.com/onlamp/blog/2007/07/assert_latest_and_greatest.html
  #  http://www.oreillynet.com/onlamp/blog/2007/07/assert_raise_on_ruby_dont_just.html
  #  http://phlip.eblogs.com/2007/01/02/growl-driven-development/
