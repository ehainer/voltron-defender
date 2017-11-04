require 'voltron/defender/command'

module Voltron
  class Defender
    class Stop < Command

      def help
        "# Stop and close the connection. It will be restarted if/when another exception occurs\n.stop|.close|.end|.disconnect\n"
      end

      def responds_to
        ['stop', 'close', 'end', 'disconnect']
      end

      def respond_with(adapter)
        if adapter.client.started?
          adapter.client.stop!
        end
      end

    end
  end
end