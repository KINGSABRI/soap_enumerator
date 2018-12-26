require_relative 'schema'

module SoapEnumerator
  class Types

    # Schema class contains all schema elements as objects
    #
    # @example:
    #   doc    = Nokogiri::XML(open(https://url/service.php?wsdl))
    #   schema = SoapEnumerator::Types::Schema.new(doc)
    #   schema.target_namespace
    #   schema.schema.complex_types
    #   schema.schema.complex_types.name
    #   all = schema.schema.complex_types.all
    #   all[0]
    #   all[0].name
    #   all[0].type
    #
    class Schemas
      include GenericHelpers

      attr_reader :list

      # @param [Nokogiri::XML::Document] types_doc
      def initialize(types_doc)
        search_terms = ['//xsd:schema', '//s:schema', '//schema']
        @list = get_schemas(safe_search(search_terms, types_doc))
      end

      private
      def get_schemas(schemas)
        schemas.map{ |schema| Types::Schemas::Schema.new(schema) }
      end

    end
  end
end