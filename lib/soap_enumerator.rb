lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nokogiri'
require 'soap_enumerator/version'
require 'soap_enumerator/definitions'
require 'soap_enumerator/types'
require 'soap_enumerator/port_types'
require 'soap_enumerator/messages'
require 'soap_enumerator/bindings'
require 'soap_enumerator/services'
require 'soap_enumerator/error'

module SoapEnumerator

  class Parse
    singleton_class.send(:alias_method, :wsdl, :new)

    # @!attribute #schema for wsdl schemas elements, it calls [Schemas] class
    attr_reader :schema
    # @!attribute #messages for wsdl Message elements, it calls [Messages] class
    attr_reader :messages
    # @!attribute #port_types for wsdl PortType elements, it calls [PortTypes] class
    attr_reader :port_types
    # @!attribute #bindings for wsdl Binding elements, it calls [Bindings] class
    attr_reader :bindings
    # @!attribute #services for wsdl Service elements, it calls [Services] class
    attr_reader :services

    def initialize(wsdl_doc)
      doc         = Nokogiri::XML(wsdl_doc)
      @schema     = Types::Schema.new(doc)
      @messages   = Messages.new(doc)
      @port_types = PortTypes.new(doc)
      @bindings   = Bindings.new(doc)
      # @services   = Services.new(doc)
    end
  end
end


if __FILE__ == $0
  require 'open-uri'
  wsdl_doc = open('http://192.168.100.10:8383/dvws/vulnerabilities/wsdlenum/service.php?wsdl')
  wsdl_doc = open('http://www.dneonline.com/calculator.asmx?WSDL')
  wsdl_doc = open('http://webstrar21.fulton.asu.edu/page1/Web%20References/weatherService/ndfdXMLserver.wsdl')
  soap_enumerator = SoapEnumerator::Parse.wsdl(wsdl_doc)
  # pp soap_enumerator.schema
  soap_enumerator.schema.target_namespace
  soap_enumerator.schema.complex_types
  soap_enumerator.schema.complex_types.name
  all = soap_enumerator.schema.complex_types.all
  if all
    all[0]
    all[0].name
    all[0].type
  end

  # pp soap_enumerator.messages.list_messages
  msg = soap_enumerator.messages.list_messages[0]
  msg
  msg.name
  msg.parts
  part = msg.parts[0]
  part.name
  part.type

  pp soap_enumerator.port_types.list_operations
  pp soap_enumerator.port_types.list_operations[0].name
  pp soap_enumerator.port_types.list_operations[0].documentation
  pp soap_enumerator.port_types.list_operations[0].input
  pp soap_enumerator.port_types.list_operations[0].output


  binding = soap_enumerator.bindings.list[0]
  binding
  binding.operations[0]
  binding.operations[0].name
  binding.operations[0].input
  binding.operations[0].output








  # soap_enumerator.service_name #=> service name
  # t1 = soap_enumerator.complex_types
  # t1[0] #=> {name: 'name', type: 'type'}
  # soap_enumerator.schemas
  # soap_enumerator.messages
  # message = soap_enumerator.messages[0]
  # message.name
  # message.part #=> {name: 'nameee', type: 'typeee'}
  # soap_enumerator.port_types
  # soap_enumerator.bindings.binding #=> {name: 'rpc', type: "tns:ssssss"}
  # soap_enumerator.bindings.soap_binding #=> {style: 'rpc', transport: "http://ssssss/http"}
  # soap_enumerator.bindings #=> [Operation1, Operation2]
  # soap_enumerator.bindings[0]  #=> OperationObj.name => "string"  ; OperationObj.soap_operation => {soap_action: 'sss', style: ''}
  # soap_enumerator.services

end



