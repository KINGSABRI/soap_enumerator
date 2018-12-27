require_relative 'types'
require_relative 'messages'
require_relative 'port_types'
require_relative 'bindings'
require_relative 'services'

module SoapEnumerator

  # Types class contains all wsdl:definitions elements as objects.
  #
  # @example:
  #   doc         = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   definitions = SoapEnumerator::Definitions.new(doc)
  #   definitions.attributes
  #   definitions.types
  #   definitions.messages
  #   definitions.port_types
  #   definitions.bindings
  #   definitions.services
  #
  class Definitions
    include GenericHelpers

    # @!attribute #attributes
    attr_reader :attributes
    # @!attribute #types for wsdl schemas elements, it calls [Types] class
    attr_reader :types
    # @!attribute #messages for wsdl Message elements, it calls [Messages] class
    attr_reader :messages
    # @!attribute #port_types for wsdl PortType elements, it calls [PortTypes] class
    attr_reader :port_types
    # @!attribute #bindings for wsdl Binding elements, it calls [Bindings] class
    attr_reader :bindings
    # @!attribute #services for wsdl Service elements, it calls [Services] class
    attr_reader :services

    def initialize(doc)
      @attributes  = attributes_2_methods(doc.search('//wsdl:definitions')[0])
      @types       = Types.new(doc)
      @messages    = Messages.new(doc)
      @port_types  = PortTypes.new(doc)
      @bindings    = Bindings.new(doc)
      @services    = Services.new(doc)
    end
  end
end