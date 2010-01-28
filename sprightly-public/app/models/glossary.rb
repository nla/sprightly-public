# Definitions and API for the RMS Glossary terms
#
# @author: pgiles
#

require 'yaml'

class Glossary

  def self.get_definition_for_term(term_code)
    SPRIGHTLY_GLOSSARY.fetch(term_code, "Definition not found for: "+term_code)
  end
end
