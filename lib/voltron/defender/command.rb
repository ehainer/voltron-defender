module Voltron
  class Defender
    class Command

      attr_accessor :input

      def parse(text)
        text.downcase!
        @input = /^\.(?<command>[a-z]+)\s*(?<id>[0-9]+)*\s*(?<args>.*)/.match(text) || {}
      end

      def matches?(text)
        parse(text)
        Array.wrap(responds_to).include?(command)
      end

      def error
        if ::Voltron::Defender::Error.exists?(id)
          ::Voltron::Defender::Error.find(id)
        elsif ::Voltron::Defender::Error.count > 0
          ::Voltron::Defender::Error.last
        else
          false
        end
      end

      def command
        @input[:command].to_s
      end

      def id
        @input[:id].to_i
      end

      def args
        @input[:args].to_s.split(/\s+/)
      end

      def answer(text, adapter)
      end

      def help
      end

    end
  end
end