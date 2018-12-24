lib = File.expand_path('..', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'nokogiri'
require 'soap_enumerator/version'
require 'soap_enumerator/helpers/string_helpers'
require 'soap_enumerator/helpers/meta_helpers'
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

    # @!attribute #definitions for wsdl schemas elements, it calls [Definitions] class
    attr_reader :definitions
    # @!attribute #types for wsdl schemas elements, it calls [Types] class
    attr_reader :types
    # @!attribute #schema for wsdl schemas elements, it calls [Schemas] class
    # attr_reader :schema
    # @!attribute #messages for wsdl Message elements, it calls [Messages] class
    attr_reader :messages
    # @!attribute #port_types for wsdl PortType elements, it calls [PortTypes] class
    attr_reader :port_types
    # @!attribute #bindings for wsdl Binding elements, it calls [Bindings] class
    attr_reader :bindings
    # @!attribute #services for wsdl Service elements, it calls [Services] class
    attr_reader :services

    # Definitions 1
    #   Types 1
    #     Schemas +1
    #       ComplexTypes 1
    #         all 1
    #           Type +1
    #   Messages
    #     Message +1
    #       Part 1
    #   Bindings
    #     Binding +1
    #       Operation +1
    #         input  1
    #           body 1
    #         output 1
    #           body 1
    #   PortTypes
    #     Operation +1
    #       documentation 1
    #       input  1
    #       output 1
    #   Services +1
    #     documentation
    #     Port +1
    #

    def initialize(wsdl_doc)
      doc = Nokogiri::XML(wsdl_doc)

      # @definitions = Definitions.new(doc)
      @types       = Types.new(doc)
      @messages    = Messages.new(doc)

      # @schema       = Types::Schema.new(doc)
      # @complex_type = Types::Schema::ComplexType.new(doc)
      # @port_types  = PortTypes.new(doc)
      # @bindings    = Bindings.new(doc)
      # @services   = Services.new(doc)
    end
  end
end


if __FILE__ == $0
  require 'open-uri'
  # wsdl_doc = open('http://192.168.100.10:8383/dvws/vulnerabilities/wsdlenum/service.php?wsdl')
  # wsdl_doc = open('http://www.dneonline.com/calculator.asmx?WSDL')
  # wsdl_doc = open('http://webstrar21.fulton.asu.edu/page1/Web%20References/weatherService/ndfdXMLserver.wsdl')
  wsdl_doc = open('/home/KING/wsdl-services/calculator-s.xml')
  wsdl_doc = open('/home/KING/wsdl-services/muliplebindings.xml')
  wsdl_doc = open('/home/KING/wsdl-services/sharepoint-search.xml')
  wsdl_doc = open('/home/KING/wsdl-services/service.xml')
  wsdl_doc = open('/home/KING/wsdl-services/sharepoint-BusinessDataCatalog.xml')
  wsdl_doc = open('/home/KING/wsdl-services/ndfdXMLserver.wsdl.xml')



  soap_enum = SoapEnumerator::Parse.wsdl(wsdl_doc)
  soap_enum.types
  soap_enum.types.schemas.list
  soap_enum.types.schemas.list[0].attributes
  soap_enum.types.schemas.list[0].target_namespace
  soap_enum.types.schemas
  soap_enum.types.schemas.list[0].complex_types[0]
  soap_enum.types.schemas.list[0].complex_types[0].all
  soap_enum.types.schemas.list[0].complex_types[0].all[-1].attributes

  # soap_enum.messages
  soap_enum.messages.list
  soap_enum.messages.list[0].attributes
  soap_enum.messages.list[0].parts
  soap_enum.messages.list[0].parts[0].name
  soap_enum.messages.list[0].parts[0].type











  # pp soap_enumerator.schema
  # soap_enumerator.schema.target_namespace
  # soap_enumerator.schema.complex_types
  # soap_enumerator.schema.complex_types.name
  # all = soap_enumerator.schema.complex_types.all
  # if all
  #   all[0]
  #   all[0].name
  #   all[0].type
  # end

  # pp soap_enumerator.messages.list_messages
  # msg = soap_enumerator.messages.list_messages[0]
  # msg
  # msg.name
  # msg.parts
  # part = msg.parts[0]
  # part.name
  # part.type
  #
  # pp soap_enumerator.port_types.list_operations
  # pp soap_enumerator.port_types.list_operations[0].name
  # pp soap_enumerator.port_types.list_operations[0].documentation
  # pp soap_enumerator.port_types.list_operations[0].input
  # pp soap_enumerator.port_types.list_operations[0].output
  #
  #
  # binding = soap_enumerator.bindings.list[0]
  # binding
  # binding.operations[0]
  # binding.operations[0].name
  # binding.operations[0].input
  # binding.operations[0].output








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



