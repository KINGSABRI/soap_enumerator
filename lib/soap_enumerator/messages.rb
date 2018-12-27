require_relative 'messages/message'

module SoapEnumerator

  # Messages class contains all message elements as objects
  #
  # @example:
  #   doc      = Nokogiri::XML(open(https://url/service.php?wsdl))
  #   messages = SoapEnumerator::Messages.new(doc)
  #   message  = messages.list[0]
  #   message.name
  #   part = message.parts[0]
  #   part.name
  #
  class Messages

    attr_reader :list

    def initialize(doc)
      @list = get_messages(doc.search('//wsdl:message'))
    end

    private

    # get_messages method generate a list of wsdl:message messages
    #
    # @param [Nokogiri::XML::Document] doc
    #
    # @return <Array[Message]>
    def get_messages(doc)
      doc&.map do |message_doc|
        Message.new(message_doc)
      end
    end
  end
end