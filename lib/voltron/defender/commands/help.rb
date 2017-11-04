require 'voltron/defender/command'

module Voltron
  class Defender
    class Help < Command

      def help
        "# Get a list of all commands I understand\n.help\n"
      end

      def responds_to
        ['help']
      end

      def respond_with(adapter)
        output = []
        adapter.commander.listeners.each { |l| output << l.help }
        adapter.message("Here are all the commands I'll respond to. Anything in `[]` is considered an optional argument. ```#{output.compact.join("\n")}```")
      end

    end
  end
end