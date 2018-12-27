require_relative 'address'

module SoapEnumerator
  class Services
    class Service
      class Port
        include GenericHelpers

        # @!attribute #attributes
        attr_reader :attributes
        # @!attribute #address
        attr_reader :address
        # @!attribute #documentation
        attr_reader :documentation

        def initialize(port_doc)
          @attributes    = attributes_2_methods(port_doc)
          @address       = get_address(port_doc)
          @documentation = get_documentation(port_doc)
        end
        
        private

        def get_documentation(doc)
          doc.search('documentation').text
        end

        def get_address(port_doc)
          Services::Service::Port::Address.new(port_doc.elements[0])
        end

      end
    end
  end
end