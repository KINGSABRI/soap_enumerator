require_relative 'port_type'

module SoapEnumerator
  class PortType
    # Operation class is a class for wsdl:operation
    class Operation
      include MetaHelper

      # @!attribute #name
      attr_accessor :name
      # @!attribute #documentation
      attr_accessor :documentation
      # @!attribute #input
      attr_accessor :input
      # @!attribute #output
      attr_accessor :output

      def initialize(name, documentation, input, output)
        @name          = name
        @documentation = documentation
        @input         = input
        @output        = output
      end
    end
  end
end