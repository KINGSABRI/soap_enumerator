require_relative 'services/service'

module SoapEnumerator
  class Services

    attr_reader :list

    def initialize(doc)
      @list = get_services(doc.search('//wsdl:service'))
    end

    private
    def get_services(doc)
      doc&.map do |service_doc|
        Services::Service.new(service_doc)
      end
    end
  end
end