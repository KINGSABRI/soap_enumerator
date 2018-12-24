# SoapEnumerator (Under heavy development)

Soap Enumerator is a Ruby gem for parsing and enumerating WSDL XML documents inspired by SoapUI. It converts the whole document into objects of itself. Using Soap Enumerator is intuitive, you can call its objects the same way you read the document.  

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'soap_enumerator'
```

Or install it yourself as:

    $ gem install soap_enumerator

## Usage

```ruby
wsdl_doc = open('http://192.168.100.10:8383/dvws/vulnerabilities/wsdlenum/service.php?wsdl')

require 'soap-enumerator' 

soap_enum = SoapEnumerator::Parse.wsdl(wsdl_doc)

# Types Elements
soap_enum.types
soap_enum.types.schemas.list
schema = soap_enum.types.schemas.list[0]
schema.attributes
schema.target_namespace
schema.complex_types 
complex_type = schema.complex_types[0] 
complex_type.all
type = complex_type.all[0]
type.attributes

# Message Elements
soap_enum.messages
soap_enum.messages.list
message = soap_enum.messages.list[0]
message.attributes
message.parts
part = message.parts[0]
part.name
part.type

# portType Elements

# Binding Elements

# Services Elements

```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/soap_enumerator.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
