require_relative 'binding'

module SoapEnumerator
  class Binding
  # Operation class is struct class for wsdl:operation
  # elements (each element is an Operation object)
  class Operation
      # @!attribute #name
      attr_reader :name
      # @!attribute #soap_action
      attr_reader :soap_action
      # @!attribute #style
      attr_reader :style
      # @!attribute #input
      attr_reader :input
      # @!attribute #output
      attr_reader :output

      def initialize(name, soap_action, style, input, output)
        @name        = name
        @soap_action = soap_action
        @style       = style
        @input       = input
        @output      = output
      end
    end
  end
end

