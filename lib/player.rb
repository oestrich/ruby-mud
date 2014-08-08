class Player
  include Celluloid::Logger

  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def say(msg)
    message = "\033[00;34m#{name}\033[00m says: #{msg}\n"
    info message.strip
    Celluloid::Actor[:message_actor].async.send_message(message)
  end
end
