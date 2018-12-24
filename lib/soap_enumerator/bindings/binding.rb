module SoapEnumerator

  # Binding class is struct class for wsdl:binding
  class Binding

    # @!attribute #name
    attr_reader :name
    # @!attribute #soap_action
    attr_reader :type
    # @!attribute #style
    attr_reader :soap_transport
    # @!attribute #input
    attr_reader :soap_style
    # @!attribute #output
    attr_reader :operations

    def initialize(name, type, soap_transport, soap_style, operations)
      @name           = name
      @type           = type
      @soap_transport = soap_transport
      @soap_style     = soap_style
      @operations     = operations
    end
  end
end