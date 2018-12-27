require_relative 'port_types/port_type'

module SoapEnumerator

  # PortTypes class contains all portType's operation elements as objects
  #
  # @example:
  #   doc        = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   port_types = SoapEnumerator::PortTypes.new(doc)
  #   port_type  = port_types.list[0]
  #   port_type.attributes
  #   port_type.name
  #   port_type.operations
  #   operation = port_type.operations[0]
  #   operation.name
  #   operation.attributes
  #   operation.input
  #   operation.output
  #
  class PortTypes

    # @!attribute #list
    attr_reader :list

    def initialize(doc)
      begin
        @list = get_port_types(doc.search('//wsdl:portType'))
      end
    end

    private

    def get_port_types(doc)
      doc&.map do |port_type|
        PortTypes::PortType.new(port_type)
      end
    end
  end
end