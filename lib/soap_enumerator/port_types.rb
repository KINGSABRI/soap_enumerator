require_relative 'port_types/port_type'

module SoapEnumerator

  # PortTypes class contains all portType's operation elements as objects
  #
  # @example:
  #   doc        = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   port_types = SoapEnumerator::PortTypes.new(doc)
  #
  class PortTypes

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