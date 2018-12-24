require_relative 'part'

module SoapEnumerator
  class Messages

    # Message class is struct class for wsd:message
    class Message
      include MetaHelper

      attr_accessor :attributes
      attr_accessor :parts

      def initialize(message_doc)
        @attributes = attributes_2_methods(message_doc)
        @parts      = get_parts(message_doc)
      end

      private

      # get_parts method create an Array of a message's parts
      #
      # @param [Nokogiri::XML::Element] message_doc
      #   Elements of wsdl:message in the wsdl document
      #
      # @return [Array<Messages::Message::Part>]
      #   returns an array of [Message::Part] objects(@see Message::Part)
      #   which contain each element's name and type
      #
      #   @note: safe navigation is used.
      #     If comp_type_doc is nil, method returns nil
      def get_parts(message_doc)
        message_doc.elements&.map do |part_doc|
          Messages::Message::Part.new(part_doc)
        end
      end

    end
  end
end