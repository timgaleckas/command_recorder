require 'rubygems'
require 'command_recorder'

require 'ruby-debug'
require 'hashie'

proc = Proc.new do
  Hashie::Mash.new &proc
end
test_object = Hashie::Mash.new &proc

cr = CommandRecorder.record do |hello|
  hello.something.something
end

CommandRecorder.playback_from_json(cr.invocation_json,test_object)
