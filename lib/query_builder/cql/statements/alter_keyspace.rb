# encoding: utf-8

module QueryBuilder::CQL

  module Statements

    # Describes the 'ALTER KEYSPACE' CQL3 statement
    #
    class AlterKeyspace < Base

      attribute :name, required: true

      # Adds WITH clause to the statement
      #
      # @param [Hash] options
      #
      # @return [QueryBuilder::Statements::AlterKeyspace]
      #
      def with(options)
        options
          .map { |key, value| Clauses::With.new(column: key, value: value) }
          .inject(self, :<<)
      end

      # Builds the statement
      #
      # @return [String]
      #
      def to_s
        cql["ALTER KEYSPACE", name.to_s, maybe_with]
      end

      private

      def maybe_with
        list = clauses(:with)
        ["WITH", list.join(" AND ")] if list.any?
      end

    end # class AlterKeyspace

  end # module Statements

end # module QueryBuilder::CQL