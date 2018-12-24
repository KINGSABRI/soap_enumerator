require_relative 'types/schemas'

module SoapEnumerator
  # Types class contains all Types elements as objects
  #
  # @example:
  #   doc   = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   types = SoapEnumerator::Types.new(doc)
  #   types.schemas
  #
  class Types

    attr_reader :schemas

    def initialize(doc)
      @schemas = Types::Schemas.new(doc.search('//wsdl:types'))
    end

  end
end
