require 'rubygems'
require 'json'

class CommandRecorder
  def self.record(&block)
    command_recorder = CommandRecorder.new
    command_recorder.store(&block)
    command_recorder
  end

  def initialize(parent=nil,label='__cr__')
    self.parent=parent
    @label=label
  end

  def store(&block)
    block.call(self)
  end

  def method_missing(*args)
    case(args[0])
    when :to_ary
      super
    else
      returning_command_recorder = CommandRecorder.new(self,args[0].to_s)
      store_invocation(self, returning_command_recorder, args)
      returning_command_recorder
    end
  end

  def store_invocation(recorder, returning_command_recorder, method_call)
    if self.parent
      self.parent.store_invocation(recorder, returning_command_recorder, method_call)
    else
      self.invocations ||= []
      self.invocations << [recorder, returning_command_recorder, method_call]
    end
  end

  def label
    "#{parent && "#{parent.label}|"}#{@label}"
  end

  def to_str
    @label
  end

  def to_json(*args)
    self.label.to_json
  end

  def invocation_json
    root.do_json
  end

  def self.playback_from_json(json,object)
    invocations = JSON.parse(json)
    objects = {'__cr__'=>object}
    invocations.each do |recorder, returning_recorder, method_call|
      objects[returning_recorder] = objects[recorder].send(*method_call)
    end
  end

  protected

  attr_accessor :invocations, :parent

  def root
    self.parent ? self.parent.root : self
  end

  def do_json
    invocations.to_json
  end
end
