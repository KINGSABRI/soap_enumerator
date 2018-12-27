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
