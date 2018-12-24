require_relative 'port_types/port_type'
require_relative 'port_types/operation'

module SoapEnumerator

  # PortTypes class contains all portType's operation elements as objects
  #
  # @example:
  #   doc        = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   port_types = SoapEnumerator::PortTypes.new(doc)
  #   operation  = port_types.list_operations[0]
  #   operation.name
  #   operation.documentation
  #   operation.input
  #   operation.output
  #
  class PortTypes
    def initialize(doc)
      begin
        @port_types = doc.search('//wsdl:portType')[0]
      # rescue Nokogiri::XML::XPath::SyntaxError
      #   @port_types = doc.search('//s:portType')[0]
      # else
      #   return nil
      end
    end

    def port_type_name
      @port_types.get_attribute('name')
    end

    # list_operations method generates a list of wsdl:operation elements
    # @return <Array[PortType::Operation]>
    def list_operations
      @port_types&.elements&.map do |operation|
        PortType::Operation.new(ops_name(operation),
                                ops_documentation(operation),
                                ops_input(operation),
                                ops_output(operation))
      end
    end
    alias_method :operations, :list_operations

    private

    def ops_name(ops)
      ops.get_attribute('name')
    end

    def ops_documentation(ops)
      ops.search('documentation').text
    end

    def ops_input(ops)
      # pp ops.search('//wsdl:input')
      # pp ops.elements.search('@[name="input"]')
      ops.search('input').get_attribute('message')
    end

    def ops_output(ops)
      ops.search('output')[0].get_attribute('message')
    end

  end
end