require 'celluloid/io'

class EchoServer
  include Celluloid::IO
  include Celluloid::Logger

  NAME_REGEX = /i am (?<name>.*)/i

  finalizer :finalize

  attr_reader :sockets

  def initialize(host, port)
    info "*** Starting echo server on #{host}:#{port}"

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
    info "*** Received connection from #{host}:#{port}"
    name = "Anonymous"
    loop do
      msg = socket.readpartial(4096)
      msg.gsub!("\n", "")
      info msg

      if match = NAME_REGEX.match(msg)
        name = match["name"].strip
        next
      end

      sockets.each do |socket|
        if socket.closed?
          sockets.delete(socket)
          next
        end
        socket.write "\033[00;34m#{name}\033[00m says: #{msg}\n"
      end
    end
  rescue EOFError
    info "*** #{host}:#{port} disconnected"
    socket.close
  end
end

supervisor = EchoServer.supervise("127.0.0.1", 1234)
trap("INT") { supervisor.terminate; exit }
sleep
