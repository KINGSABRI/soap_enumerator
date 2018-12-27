require_relative 'types/schema'

module SoapEnumerator
  # Types class contains all Types elements as objects
  #
  # @example:
  #   doc   = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   types = SoapEnumerator::Types.new(doc)
  #   schemas = types.schemas
  #   schema = schemas[0]
  #   schema.attributes
  #   schema.target_namespace
  #   complex_types = schema.complex_types
  #   complex_type = complex_types[-1]
  #   ctype = complex_type.all[0]
  #   ctype.attributes
  #   simple_types = schema.simple_types
  #   simple_types = simple_types
  #   simple_type = simple_types[0]
  #   stype = simple_type.all[0]
  #   stype.attributes
  #
  class Types
    include GenericHelpers

    # @!attribute #schemas
    attr_reader :schemas

    # @param [Nokogiri::XML::Document] doc
    def initialize(doc)
      @schemas = get_schemas(doc.search('//wsdl:types'))
    end

    private

    def get_schemas(types_doc)
      search_terms = ['//./xsd:schema', '//./s:schema', '//schema']
      schemas      = safe_search(search_terms, types_doc)
      schemas.map { |schema| Types::Schema.new(schema) unless schema.nil? }
    end
  end
end
