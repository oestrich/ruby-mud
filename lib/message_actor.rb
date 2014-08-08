class MessageActor
  include Celluloid

  def send_message(msg)
    Celluloid::Actor[:server].sockets.each do |socket|
      socket.write msg
    end
  end
end
