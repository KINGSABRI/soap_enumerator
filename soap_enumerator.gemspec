
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "soap_enumerator/version"

Gem::Specification.new do |s|
  s.name          = "soap_enumerator"
  s.version       = SoapEnumerator::VERSION
  s.authors       = ["KING SABRI"]
  s.email         = ["king.sabri@gmail.com"]

  s.summary       = %q{A gem for SOAP/WSDL enumeration inspired by SoapUI.}
  s.description   = %q{A gem for SOAP/WSDL enumeration inspired by SoapUI. It converts all SOAP's document to ruby objects.}
  s.homepage      = "https://github.com/KINGSABRI/soap_enumerator"
  s.license       = "LGPL-3.0"

  s.require_paths = ["lib"]
  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  s.add_runtime_dependency     'nokogiri', '~> 1.8', '>= 1.8.0'
  s.add_development_dependency "bundler", "~> 1.17"
  s.add_development_dependency "rake", "~> 10.0"
end
