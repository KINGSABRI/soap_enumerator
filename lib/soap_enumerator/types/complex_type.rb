require_relative 'type'

module SoapEnumerator
  class Types
    class Schemas
      class Schema
        # ComplexType class is struct class for complexType
        class ComplexType
          include GenericHelpers

          attr_reader :attributes
          attr_reader :all

          def initialize(comp_type_doc)
            @attributes = attributes_2_methods(comp_type_doc)
            @all = get_type_doc(comp_type_doc)
          end


          private

          def get_type_doc(comp_type_doc)
            begin
              comp_type_doc&.search('//xsd:element')&.map do |element|
                # Type.new(e.get_attribute('name'), e.get_attribute('type'))
                Types::Schemas::Schema::ComplexType::Type.new(element)
              end
            rescue Nokogiri::XML::XPath::SyntaxError
              comp_type_doc&.search('//s:element')&.map do |element|
                # Type.new(e.get_attribute('name'), e.get_attribute('type'))
                Types::Schemas::Schema::ComplexType::Type.new(element)
              end
            rescue Exception => e
              puts "[!] The element 'element' Could not be found in the document!"
              puts e.full_message
            end
          end
        end
      end
    end
  end
end