# This is to change the default behaviour of coverting Oracle Number to big decimal
# Will convert them to int instead
ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.emulate_integers_by_column_name = true

# Overrides the defualt naming of Oracle Sequence numbers
module ActiveRecord
  module ConnectionAdapters
    class OracleEnhancedAdapter
      # Returns default sequence name for table.
      # Will take all or first 26 characters of table name and append _seq suffix
      def default_sequence_name(table_name, primary_key = nil)
        "sq_#{table_name.to_s[0,IDENTIFIER_MAX_LENGTH-4]}"
      end
    end
  end
end