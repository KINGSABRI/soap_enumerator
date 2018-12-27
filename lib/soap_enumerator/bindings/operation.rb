module SoapEnumerator
  class Bindings
    class Binding
      # Operation class is struct class for wsdl:operation
      # elements (each element is an Operation object)
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
          @input         = get_operation(ops_doc, 'input')
          @output        = get_operation(ops_doc, 'output')
          @documentation = get_documentation(ops_doc)
        end

        private
        def get_documentation(doc)
          doc.search('documentation').text
        end

        def get_operation(doc, operation)
          doc.elements
             .select {|ops| ops.name.include?(operation)}[0]
             .elements.map {|e| attributes_2_hashes(e.attributes) }.flatten
        end
      end
    end
  end
end

