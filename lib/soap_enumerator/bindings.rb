require_relative 'bindings/binding'
# require_relative 'bindings/operation'

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

    attr_reader :list

    def initialize(doc)
      @list = get_bindings(doc.search('//wsdl:binding'))
    end

    private

    # get_bindings method extracts a binding's name
    #
    # @param [Nokogiri::XML::Element] doc
    #   Elements of wsdl:binding in the wsdl document
    #
    # @return [Array<Binding>]
    #   returns array of Binding objects
    #
    #   @note: safe navigation is used.
    #     If doc is nil, method returns nil
    def get_bindings(doc)
      doc&.map do |binding_doc|
        Bindings::Binding.new(binding_doc)
      end
    end
  end
end