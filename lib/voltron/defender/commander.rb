module Voltron
  class Defender
    class Commander

      def initialize
        @listeners = []
      end

      def matches?(text)
        processor(text).present?
      end

      def processor(text)
        @listeners.find do |listener|
          listener.matches?(text)
        end
      end

      def listeners
        @listeners || []
      end

      def listen_to(klass)
        @listeners << klass.new
      end

    end
  end
end