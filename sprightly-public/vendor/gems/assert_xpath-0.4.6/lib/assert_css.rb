require File.dirname(__FILE__) + '/../lib/assert_xpath.rb'
require 'css_parser'
require 'pathname'


module AssertCSS

  def assert_css(block)
    @_cp ||= CssParser::Parser.new
    @_cp.add_block!(block)
  end

    # from http://www.w3.org/TR/CSS21/page.html#page-selectors

  def assert_css_selector(selector)
    raise 'selector must be a string' unless selector.kind_of? String
    # ERGO  why no return me a RuleSet??
    return @_cp.find_by_selector(selector)
  end
  
  def _find_css_style(selector, rule)
    @_cp.each_rule_set do |rule_set|
      if rule_set.selectors.include?(selector) and
         value = rule_set.get_value(rule)
        return value.sub(/;$/, '')
      end
    end
    return nil
  end
  
  def assert_css_public_folder(root)
    @_public_folder = root
  end

  def assert_css_style(selector, rule)
    if selector.respond_to? :delete_attribute
#p selector.name
      return _find_css_style(selector.name, rule)
    else
      _find_css_style(selector, rule) or
        flunk "#{selector}{#{rule}} not found"
    end
  end

  def assert_style(path = :style)
    assert_any_xpath path do |style|
      assert_css style.text
      false
    end
  end

end