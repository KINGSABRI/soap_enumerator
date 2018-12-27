require_relative 'port'

module SoapEnumerator
  class Services
    class Service
      include GenericHelpers

      # @!attribute #attributes
      attr_reader :attributes
      # @!attribute #ports
      attr_reader :ports

      attr_reader :documentation

      def initialize(service_doc)
        @attributes    = attributes_2_methods(service_doc)
        @ports         = get_ports(service_doc)
        @documentation = get_documentation(service_doc)
      end

      private

      def get_documentation(doc)
        doc.search('documentation').text
      end

      def get_ports(service_doc)
        service_doc.search('//wsdl:port').map do |port|
          Services::Service::Port.new(port)
        end
      end
    end
  end
end