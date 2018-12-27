require_relative 'operation'

module SoapEnumerator

  class PortTypes
    # PortType class is struct class for wsdl:portType
    class PortType
      include GenericHelpers

      # @!attribute #attributes
      attr_reader :attributes
      # @!attribute #operations
      attr_reader :operations

      def initialize(port_type_doc)
        @attributes = attributes_2_methods(port_type_doc)
        @operations = get_operations(port_type_doc)
      end

      private

      # get_operations method
      #
      # @param [Nokogiri::XML::Document] port_type_doc
      #
      # @return [Array<Operation>]
      #   return object of [Operation] contains the name of the Operation
      #   and array of all existing operations. (@see #Operation)
      def get_operations(port_type_doc)
        port_type_doc.search('//wsdl:operation')&.map do |operation|
          PortTypes::PortType::Operation.new(operation)
        end
      end
    end
  end
end