module SoapEnumerator
  class Messages
    class Message

      # Part class is struct class for wsd:part elements (each element is a Part object).
      class Part
        include MetaHelper

        attr_reader :attributes

        def initialize(part_doc)
          @attributes = attributes_2_methods(part_doc)
        end
      end

    end
  end
end
