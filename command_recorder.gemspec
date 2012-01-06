
# -*- encoding: utf-8 -*-
$:.push('lib')
require "command_recorder/version"

Gem::Specification.new do |s|
  s.name     = "command_recorder"
  s.version  = CommandRecorder::VERSION.dup
  s.date     = "2012-01-06"
  s.summary  = "let's you record actions on a stub and play them back on a real object later (or on a different system)"
  s.email    = "tim@galeckas.com"
  s.homepage = "http://todo.project.com/"
  s.authors  = ['Tim Galeckas']
  
  s.description = <<-EOF
  let's you record actions on a stub and play them back on a real object later (or on a different system)
EOF
  
  dependencies = [
    # Examples:
    [:runtime,     "json",   "~> 1.6.4"],
    [:development, "hashie", "~> 1.2.0"],
  ]
  
  s.files         = Dir['**/*']
  s.test_files    = Dir['test/**/*'] + Dir['spec/**/*']
  s.executables   = Dir['bin/*'].map { |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  
  ## Make sure you can build the gem on older versions of RubyGems too:
  s.rubygems_version = "1.6.2"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.specification_version = 3 if s.respond_to? :specification_version
  
  dependencies.each do |type, name, version|
    if s.respond_to?("add_#{type}_dependency")
      s.send("add_#{type}_dependency", name, version)
    else
      s.add_dependency(name, version)
    end
  end
end
