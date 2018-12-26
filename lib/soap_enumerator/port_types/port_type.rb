require_relative 'operation'

module SoapEnumerator

  class PortTypes
    # PortType class is struct class for wsdl:portType
    class PortType
      include GenericHelpers

      attr_reader :attributes

      attr_reader :operations

      def initialize(port_type_doc)
        @attributes = attributes_2_methods(port_type_doc)
        @operations = get_operations(port_type_doc)
      end

      private
      def get_operations(port_type_doc)
        port_type_doc.search('//wsdl:operation')&.map do |operation|
          PortTypes::PortType::Operation.new(operation)
        end
      end
    end
  end
end