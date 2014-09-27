class Server
  include Celluloid::IO
  include Celluloid::Logger

  finalizer :finalize

  attr_reader :sockets

  def initialize(host, port)
    info "Starting server on #{host}:#{port}"

    @sockets = []

    # Since we included Celluloid::IO, we're actually making a
    # Celluloid::IO::TCPServer here
    @server = TCPServer.new(host, port)
    async.run
    async.tick
  end

  def finalize
    @server.close if @server
  end

  def run
    loop { async.handle_connection @server.accept }
  end

  def tick
    loop { sockets.each { |socket| socket.write "TICK\n" }; sleep 10 }
  end

  def handle_connection(socket)
    sockets << socket
    _, port, host = socket.peeraddr
    info "Received connection from #{host}:#{port}"

    player = Player.new(self, "Anonymous")
    loop do
      msg = socket.readpartial(4096)
      msg.strip!

      player.received_message(msg)
    end
  rescue EOFError
    info "#{host}:#{port} disconnected"
    sockets.delete(socket)
    socket.close
  end

  def send_message(msg)
    sockets.each do |socket|
      socket.puts msg
    end
  end
end
