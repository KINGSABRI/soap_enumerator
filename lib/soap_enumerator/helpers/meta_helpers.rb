require_relative 'string_helpers'

module SoapEnumerator
  module MetaHelper
    include StringHelper

    # get each attribute,
    # convert it to a singleton method.
    # the new method's name comes from the attribute's name. (convert attr' name to snake_case)
    # then get the method's value from the attribute's value
    #
    # @param [Nokogiri::XML::NodeSet] schema
    #
    # @return [Array<Symbol>]
    #   Array of symbols which actually now are singleton methods with values
    # @todo make this method as helper, we going to need it for all classes
    def attributes_2_methods(element)
      element.attributes.map do |_k, attr_v|
        define_singleton_method(to_snake_case(attr_v.name).to_sym) { attr_v.value }
      end
    end
  end
end