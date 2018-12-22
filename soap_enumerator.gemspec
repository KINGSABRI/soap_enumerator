
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "soap_enumerator/version"

Gem::Specification.new do |spec|
  spec.name          = "soap_enumerator"
  spec.version       = SoapEnumerator::VERSION
  spec.authors       = ["KING SABRI"]
  spec.email         = ["king.sabri@gmail.com"]

  spec.summary       = %q{A gem for SOAP/WSDL enumeration inspired by SoapUI.}
  spec.description   = %q{A gem for SOAP/WSDL enumeration inspired by SoapUI}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", ">= 1.8.0"
  spec.add_development_dependency "bundler", "~> 1.17"
  spec.add_development_dependency "rake", "~> 10.0"
end
