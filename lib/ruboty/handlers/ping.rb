module Ruboty
  module Handlers
    class Ping < Base
      on(/ping\z/i, name: "ping", description: "Return PONG to PING", command: "ping")

      def ping(message)
        Ruboty::Actions::Ping.new(message).call
      end
    end
  end
end
