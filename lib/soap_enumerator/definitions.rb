require_relative 'types'
require_relative 'messages'
require_relative 'port_types'
require_relative 'bindings'
require_relative 'services'

module SoapEnumerator
  class Definitions
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

    def initialize(wsdl_doc)
      @attributes  = attributes_2_methods(doc.search('//wsdl:definitions'))

      @types       = Types.new(doc)
      @messages    = Messages.new(doc)
      @port_types  = PortTypes.new(doc)
      @bindings    = Bindings.new(doc)
      @services    = Services.new(doc)

      @definitions = doc.search('//wsdl:definitions')[0]
    end
  end


  # target_namespace method extracts the definitions' targetNamespace from [Nokogiri::XML::Element] object
  def target_namespace
    @definitions.get_attribute('targetNamespace')
  end

  def name
    @definitions.get_attribute('name')
  end
end