require 'voltron/defender/command'

module Voltron
  class Defender
    class Trace < Command

      def help
        "# Retrieve the stack trace for the most recent exception id, or the specific exception if an id is provided\n.trace|.backtrace|.stack|.stacktrace [id]\n"
      end

      def responds_to
        ['trace', 'backtrace', 'stack', 'stacktrace']
      end

      def respond_with(adapter)
        if error
          adapter.upload("Stack Trace ##{error.id}", "Here's the stack trace for #{error.name.downcase}", error.trace)
        else
          adapter.message('Sorry, I wasn\'t able to find any exception to provide information on. Try specifying an exception id, like `.<command> <id>`')
        end
      end

    end
  end
end