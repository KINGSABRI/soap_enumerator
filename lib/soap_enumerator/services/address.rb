module SoapEnumerator
  class Services
    class Service
      class Port
        class Address
          include GenericHelpers

          # @!attribute #attributes
          attr_reader :attributes

          def initialize(addr_doc)
            @attributes = attributes_2_methods(addr_doc)
          end
        end
      end
    end
  end
end
