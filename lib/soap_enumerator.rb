lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nokogiri'
require 'soap_enumerator/version'
require 'soap_enumerator/helpers/generic_helpers'
require 'soap_enumerator/definitions'
require 'soap_enumerator/types'
require 'soap_enumerator/port_types'
require 'soap_enumerator/messages'
require 'soap_enumerator/bindings'
require 'soap_enumerator/services'
require 'soap_enumerator/error'

module SoapEnumerator

  class Parse
    singleton_class.send(:alias_method, :wsdl, :new)  # an alias for class method #new

    # @!attribute #definitions for wsdl schemas elements, it calls [Definitions] class
    attr_reader :definitions
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
      doc = Nokogiri::XML(wsdl_doc)

      @definitions = Definitions.new(doc)
      @types       = Types.new(doc)
      @messages    = Messages.new(doc)
      @port_types  = PortTypes.new(doc)
      @bindings    = Bindings.new(doc)
      @services    = Services.new(doc)
    end
  end
end


if __FILE__ == $0
  require 'open-uri'
  require "awesome_print"

  # wsdl_doc = open('http://192.168.100.10:8383/dvws/vulnerabilities/wsdlenum/service.php?wsdl')
  # wsdl_doc = open('http://www.dneonline.com/calculator.asmx?WSDL')
  # wsdl_doc = open('http://webstrar21.fulton.asu.edu/page1/Web%20References/weatherService/ndfdXMLserver.wsdl')
  wsdl_doc = open('/home/KING/wsdl-services/muliplebindings.xml')
  wsdl_doc = open('/home/KING/wsdl-services/service.xml')
  wsdl_doc = open('/home/KING/wsdl-services/ndfdXMLserver.wsdl.xml')
  wsdl_doc = open('/home/KING/wsdl-services/calculator-s.xml')
  wsdl_doc = open('/home/KING/wsdl-services/sharepoint-search.xml')
  wsdl_doc = open('/home/KING/wsdl-services/sharepoint-BusinessDataCatalog.xml')



  soap_enum = SoapEnumerator::Parse.wsdl(wsdl_doc)

  ## Definitions
  definitions = soap_enum.definitions
  definitions.attributes
  definitions.types
  definitions.messages
  definitions.port_types
  definitions.bindings
  definitions.services

  ## Types
  types = soap_enum.types
  schemas = types.schemas
  schema = schemas[0]
  schema.attributes
  schema.target_namespace
  complex_types = schema.complex_types
  complex_type = complex_types[0]
  ctype = complex_type.all[0]
  ctype&.attributes
  simple_types = schema.simple_types
  simple_type = simple_types[0]
  stype = simple_type.all[0] if simple_type
  stype&.attributes

  ## Messages
  soap_enum.messages
  messages = soap_enum.messages.list
  message = messages[0]
  message.attributes
  part = message.parts[0]
  part.name

  ## PortTypes
  soap_enum.port_types
  port_types = soap_enum.port_types.list
  port_type  = port_types[0]
  port_type.attributes
  port_type.name
  port_type.operations
  operation = port_type.operations[0]
  operation.name
  operation.attributes
  operation.input
  operation.output

  ## Bindings
  soap_enum.bindings
  bindings  = soap_enum.bindings.list
  binding   = bindings[0]
  binding.attributes
  binding.soap_binding
  operation = binding.operations[0]
  operation.attributes
  operation.name
  operation.input
  operation.output

  ## Services
  soap_enum.services.list
  service = soap_enum.services.list[0]
  service.name
  ports = service.ports
  port = ports[0]
  port.attributes
  port.address
end


