module SoapEnumerator

  # PortType class is struct class for wsdl:portType
  class PortType
    # @!attribute #name
    attr_accessor :name
    # @!attribute #operation
    attr_accessor :operation
    def initialize(name, parts)
      @name  = name
      @parts =  parts
    end
  end

end