class SupervisorGroup < Celluloid::SupervisionGroup
  supervise Server, :as => :server, :args => ["127.0.0.1", 1234]
end
