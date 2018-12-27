require_relative 'type'

module SoapEnumerator
  class Types
    class Schema
      # ComplexType class is struct class for complexType
      class SimpleType
        include GenericHelpers

        # @!attribute #attributes
        attr_reader :attributes
        # @!attribute #all
        attr_reader :all

        def initialize(comp_type_doc)
          @attributes = attributes_2_methods(comp_type_doc)
          @all = get_type_doc(comp_type_doc)
        end

        private

        # get_type_doc method
        #
        # @param [Nokogiri::XML::Document] comp_type_doc
        #
        # @return [Array<Type>]
        #   return object of [Type] contains the name of the Type
        #   and array of all existing types. (@see #Type)
        def get_type_doc(comp_type_doc)
          search_terms = ['./*/xsd:element', './*/s:element', './s:restriction']
          # search_terms = ['./s:restriction', './*/xsd:element', './*/s:element']
          safe_search(search_terms, comp_type_doc)&.map do |element|
            Types::Schema::Type.new(element) unless element.nil?
          end
        end
      end
    end
  end
end