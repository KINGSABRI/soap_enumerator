require_relative 'operation'

module SoapEnumerator
  class Bindings
    # Binding class is struct class for wsdl:binding
    class Binding
      include GenericHelpers

      # @!attribute #attributes
      attr_reader :attributes
      # @!attribute #soap_binding
      attr_reader :soap_binding
      # @!attribute #operations
      attr_reader :operations

      def initialize(binding_doc)
        # @name           = name
        # @type           = type
        @attributes   = attributes_2_methods(binding_doc)
        @soap_binding = get_soap_binding(binding_doc)
        @operations   = get_operations(binding_doc)
      end

      private

      def get_soap_binding(binding_doc)
        binding_doc.search('//soap:binding').map do |sb|
          attributes_2_hashes(sb.attributes)
        end.flatten
      end

      def get_operations(binding_doc)
        binding_doc.search('//wsdl:binding/wsdl:operation').map do |ops|
          Bindings::Binding::Operation.new(ops)
        end
      end
    end

  end
end