module SoapEnumerator
  module GenericHelpers

    def to_snake_case(string)
      string.gsub(/::/, '/')
            .gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
            .gsub(/([a-z\d])([A-Z])/,'\1_\2')
            .tr("-", "_")
            .downcase
    end

    # get each attribute,
    # convert it to a singleton method.
    # the new method's name comes from the attribute's name. (convert attr' name to snake_case)
    # then get the method's value from the attribute's value
    #
    # @param [Nokogiri::XML::NodeSet] element
    #
    # @return [Array<Symbol>]
    #   Array of symbols which actually now are singleton methods with values
    def attributes_2_methods(element)
      element.attributes.map do |_k, attr_v|
        define_singleton_method(to_snake_case(attr_v.name).to_sym) { attr_v.value }
      end
    end

    def attributes_2_hashes(attributes)
      attributes.values.map {|attr| {attr.name => attr.value}}.flatten
    end

    # safe_search method
    #   Safely search multiple terms in a document or raise exception.
    # @param [Array<String>] search_terms
    #   Array of possible search terms to look for.
    #
    # @param [Nokogiri::XML::Document] doc
    #   The document to search in using Nokogiri::XML::NodeSet#search method
    #
    # @return [Array<Nokogiri::XML::NodeSet>]
    #   return the search's result as an array of [Nokogiri::XML::NodeSet] objects
    def safe_search(search_terms, doc)
      search_terms.map do |term|
        begin
          result = doc.search(term)
          if result.empty? or result.nil?
            next
          else
            return result
          end
        rescue Nokogiri::XML::XPath::SyntaxError
          next
        rescue Exception => e
          puts e.full_message
        end
      end
    end
  end
end