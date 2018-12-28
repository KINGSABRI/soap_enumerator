module SoapEnumerator
  class PortTypes
    class PortType
      # Operation class is a class for wsdl:operation
      class Operation
        include GenericHelpers

        # @!attribute #attributes
        attr_reader :attributes
        # @!attribute #documentation
        attr_reader :documentation
        # @!attribute #input
        attr_reader :input
        # @!attribute #output
        attr_reader :output

        def initialize(ops_doc)
          @attributes    = attributes_2_methods(ops_doc)
          @documentation = get_documentation(ops_doc)
          @input         = get_operation(ops_doc, 'input')
          @output        = get_operation(ops_doc, 'output')
        end

        private
        def get_documentation(doc)
          doc.search('documentation').text
        end

        def get_operation(doc, operation)
          attributes_2_hashes(
              doc.elements
                  .select {|ops| ops.name.include?(operation)}[0]
                  .attributes
          )
        end
      end
    end
  end
end