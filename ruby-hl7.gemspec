$:.push File.expand_path("../lib", __FILE__)
require "ruby-hl7/version"

Gem::Specification.new do |s|
  s.name = 'ruby-hl7'
  s.version = Ruby::HL7::VERSION
  s.authors = ["Mark Guzman", "Randy Secrist"]
  s.date = %q{2012-02-08}
  s.summary = %q{A simple library to parse and generate HL7 2.x messages}
  s.description = %q{A simple library to parse and generate HL7 2.x messages}
  s.email = %q{randy.secrist@gmail.com}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # Testing
  s.add_development_dependency "rake"
  s.add_development_dependency "rantly"
  s.add_development_dependency "minitest"

end
