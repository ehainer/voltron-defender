require 'voltron/defender/command'

module Voltron
  class Defender
    class When < Command

      include ::ActionView::Helpers::DateHelper

      def help
        "# Find out when the most recent exception occurred, or a specific exception if an id is given\n.when|.time [id]\n"
      end

      def responds_to
        ['when', 'time']
      end

      def respond_with(adapter)
        if error
          adapter.message("#{error.name} happened #{distance_of_time_in_words(Time.now, error.created_at)} ago")
        else
          adapter.message('Sorry, I wasn\'t able to find any exception to provide information on. Try specifying an exception id, like `.<command> <id>`')
        end
      end

    end
  end
end