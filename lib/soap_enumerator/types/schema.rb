require_relative 'complex_type'
require_relative 'simple_type'

module SoapEnumerator
  class Types
    # Schema class contains all schema elements as objects.
    #   It dynamically detects schema attributes then generates
    #   attributes for these attributes.
    #   Also, it contains the complexType objects
    #
    # @example:
    #   @see #Types
    #
    class Schema

      include GenericHelpers

      # @!attribute #attributes
      attr_reader :attributes
      # @!attribute #complex_types
      attr_reader :complex_types
      # @!attribute #simple_types
      attr_reader :simple_types

      def initialize(schema_doc)
        @attributes    = attributes_2_methods(schema_doc)
        @complex_types = get_complex_types(schema_doc)
        @simple_types  = get_simple_types(schema_doc)
      end

      private

      # get_complex_types method
      #
      # @param [Nokogiri::XML::Document] schema_doc
      #
      # @return [Array<ComplexType>]
      #   return object of [ComplexType] contains the name of the complexType
      #   and array of all existing types. (@see #Schema::ComplexType)
      def get_complex_types(schema_doc)
        search_terms = ['//./xsd:complexType', '//./s:complexType', '//./complexType']
        safe_search(search_terms, schema_doc)&.map do |comp_types_doc|
          Types::Schema::ComplexType.new(comp_types_doc)
        end
      end

      # get_simple_types method
      #
      # @param [Nokogiri::XML::Document] schema_doc
      #
      # @return [Array<SimpleType>]
      #   return object of [SimpleType] contains the name of the simpleType
      #   and array of all existing types. (@see #Schema::SimpleType)
      def get_simple_types(schema_doc)
        search_terms = ['//./xsd:simpleType', '//./s:simpleType', '//./simpleType']
        safe_search(search_terms, schema_doc)&.map do |comp_types_doc|
          Types::Schema::SimpleType.new(comp_types_doc)
        end
      end
    end
  end
end