# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "pag_seguro/version"

Gem::Specification.new do |s|
  s.name        = "pag_seguro"
  s.version     = PagSeguro::VERSION
  s.author      = "Sebastian Gamboa"
  s.email       = "me@sagmor.com"
  s.homepage    = "https://github.com/sagmor/pag_seguro"
  s.summary     = %q{Simple PagSeguro implementation}
  s.description = %q{Simple PagSeguro implementation}

  s.rubyforge_project = "pag_seguro"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_runtime_dependency "hashie"
  s.add_runtime_dependency "multi_xml"
  s.add_runtime_dependency "builder"
  s.add_runtime_dependency "rest-client"
end
