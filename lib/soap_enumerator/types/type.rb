module SoapEnumerator
  class Types
      class Schema
      # Type class is struct class for xsd:all elements (each element is a Type object).
      class Type
        include GenericHelpers

        # @!attribute #attributes
        attr_reader :attributes

        def initialize(type_doc)
          @attributes = attributes_2_methods(type_doc)
        end
      end
    end
  end
end
