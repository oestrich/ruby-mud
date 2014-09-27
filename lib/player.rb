class Player
  include Celluloid::Logger

  NAME_REGEX = /i am (?<name>.*)/i

  attr_accessor :name

  attr_reader :server
  private :server

  def initialize(server, name)
    @server = server
    self.name = name
  end

  def received_message(message)
    if match = NAME_REGEX.match(message)
      self.name = match["name"].strip
      return
    end

    say(message)
  end

  def say(msg)
    message = Line.color(:blue, name).color(:white, " says: #{msg}").to_s
    info message.strip
    server.async.send_message(message)
  end
end
