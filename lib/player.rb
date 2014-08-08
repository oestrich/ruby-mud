class Player
  include Celluloid::Logger

  attr_accessor :name

  attr_reader :server
  private :server

  def initialize(server, name)
    @server = server
    self.name = name
  end

  def say(msg)
    message = Line.color(:blue, name).color(:white, " says: #{msg}").to_s
    info message.strip
    server.async.send_message(message)
  end
end
