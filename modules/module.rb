# frozen_string_literal: true

Dir['*-module.rb'].each do |file|
  require file
end
module BotModule
  def start; end

  def command(_command, _args)
    false
  end

  def stop; end
end
class ModuleManager
  def initialize(modules)
    @modules = modules
  end

  def start
    @modules.each(&:start)
  end

  def command(command, args)
    @modules.each { |botModule| botModule.command(command, args) }
  end

  def stop
    @modules.each(&:stop)
  end
  attr_reader :modules
end
