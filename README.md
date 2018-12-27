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
types   = soap_enum.types
schemas = types.schemas
schema  = schemas[0]
schema.attributes
schema.target_namespace
complex_types = schema.complex_types
complex_type  = complex_types[0]
ctype = complex_type.all[0]
ctype.attributes
simple_types = schema.simple_types
simple_types = simple_types
simple_type  = simple_types[0]
stype = simple_type.all[0]
stype.attributes

# Message Elements
soap_enum.messages
messages = soap_enum.messages.list
message  = messages[0]
message.attributes
part     = message.parts[0]
part.name

# portType Elements
soap_enum.port_types
port_types = soap_enum.port_types.list
port_type  = port_types[0]
port_type.attributes
port_type.name
port_type.operations
operation = port_type.operations[0]
operation.name
operation.attributes
operation.input
operation.output

# Binding Elements
soap_enum.bindings
bindings  = soap_enum.bindings.list
binding   = bindings[0]
binding.attributes
operation = binding.operations[0]
operation.attributes
operation.name
operation.input
operation.output
  
# Services Elements
soap_enum.services.list
service = soap_enum.services.list[0]
service.name
ports = service.ports
port  = ports[0]
port.attributes
port.address
```


## Contributing
1. Fork it ( https://github.com/KINGSABRI/soap_enumerator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

The gem is available as open source under the terms of the [LGPL-3.0 License](https://opensource.org/licenses/LGPL-3.0).
