require_relative 'bindings/binding'
require_relative 'bindings/operation'

module SoapEnumerator

  # Bindings class contains all bindings and its operations
  #
  # @example:
  #   doc      = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   bindings = SoapEnumerator::Bindings.new(doc)
  #   binding  = bindings.bindings.list[0]
  #   pp binding
  #   pp binding.operations[0]
  #   pp binding.operations[0].name
  #   pp binding.operations[0].input
  #   pp binding.operations[0].output
  #
  class Bindings

    def initialize(doc)
      # review all docuement parts and iterate over the search
      # not just take the first element .. @todo:check port_types
      @bindings = doc.search('//wsdl:binding')
    end

    # list_operations method generates a list of wsdl:binding elements
    # @return <Array[Binding]>
    def list_bindings
      @bindings&.map do |binding|
        Binding.new(binding_name(binding),
                    binding_type(binding),
                    binding_soap_transport(binding),
                    binding_soap_style(binding),
                    binding_ops(binding))
      end
    end
    alias_method :list, :list_bindings


    private

    # binding_name method extracts a binding's name
    #
    # @param [Nokogiri::XML::Element] binding
    #   Elements of wsdl:binding in the wsdl document
    # @return [String]
    #   returns string of the binding name
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def binding_name(binding)
      binding.get_attribute('name')
    end

    # binding_type method extracts a binding's name type
    #
    # @param [Nokogiri::XML::Element] binding
    #   Elements of wsdl:binding in the wsdl document
    # @return [String]
    #   returns string of the binding type
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def binding_type(binding)
      binding.get_attribute('type')
    end

    # binding_type method extracts binding's transport
    #
    # @param [Nokogiri::XML::Element] binding
    #   Elements of wsdl:binding in the wsdl document
    # @return [String]
    #   returns string of the binding transport
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def binding_soap_transport(binding)
      binding.get_attribute('name')
    end

    # binding_soap_style method extracts binding's style
    #
    # @param [Nokogiri::XML::Element] binding
    #   Elements of wsdl:binding in the wsdl document
    # @return [Array<Message::Part>]
    #   returns string of the binding style
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def binding_soap_style(binding)
      binding.get_attribute('name')
    end

    # binding_ops method creates an Array of a binding's operations
    #
    # @param [Nokogiri::XML::Element] binding
    #   Elements of wsdl:message in the wsdl document
    # @return [Array<Binding::Operation>]
    #   returns an array of [Binding::Operation]
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def binding_ops(binding)
      binding.elements.search('operation')&.map do |operation|
        Binding::Operation.new(ops_name(operation),
                               ops_soap_action(operation),
                               ops_soap_style(operation),
                               ops_input(operation),
                               ops_output(operation))
      end
    end

    # ops_name method extracts an operation's name
    #
    # @param [Nokogiri::XML::Element] ops
    #   Elements of wsdl:operation in the wsdl document
    # @return [String]
    #   returns string of the operation name
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def ops_name(ops)
      ops.get_attribute('name')
    end

    # ops_name method extracts an operation's soapAction
    #
    # @param [Nokogiri::XML::Element] ops
    #   Elements of wsdl:operation in the wsdl soapAction
    # @return [String]
    #   returns string of the operation soapAction
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def ops_soap_action(ops)
      ops.elements[0].get_attribute('soapAction')
    end

    # ops_name method extracts an operation's style
    #
    # @param [Nokogiri::XML::Element] ops
    #   Elements of wsdl:operation in the wsdl document
    # @return [String]
    #   returns string of the operation style
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def ops_soap_style(ops)
      ops.elements[0].get_attribute('style')
    end

    # ops_input method creates an array hashes of operation's input attributes
    #
    # @param [Nokogiri::XML::Element] ops
    #   Elements of wsdl:operation in the wsdl document
    # @return [Array<hash>]
    #   returns an array hashes of operation's input attributes
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def ops_input(ops)
      ops.search('input')[0]&.elements&.map do |body|
        body.attributes&.map {|k, v| {k => v.value}}
      end.flatten
    end

    # ops_input method creates an array hashes of operation's output attributes
    #
    # @param [Nokogiri::XML::Element] ops
    #   Elements of wsdl:operation in the wsdl document
    # @return [Array<hash>]
    #   returns an array hashes of operation's output attributes
    #
    #   @note: safe navigation is used.
    #     If comp_type_doc is nil, method returns nil
    def ops_output(ops)
      ops.search('output')[0]&.elements&.map do |body|
        body.attributes&.map {|k, v| {k => v.value}}
      end.flatten
    end

  end
end