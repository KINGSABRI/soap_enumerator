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
      attr_reader :list

      # @param [Nokogiri::XML::Document] types_doc
      def initialize(types_doc)
        begin
          # @schemas = doc.search('//xsd:schema')
          @list = get_schemas(types_doc.search('//xsd:schema'))
        rescue Nokogiri::XML::XPath::SyntaxError
          # @schemas = doc.search('//s:schema')
          @list = get_schemas(types_doc.search('//s:schema'))
        rescue Exception => e
          puts e.full_message
        end
      end

      private
      def get_schemas(schemas)
        schemas.map{ |schema| Types::Schemas::Schema.new(schema) }
      end

    end
  end
end