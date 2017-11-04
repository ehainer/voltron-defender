module Voltron
  class Defender
    class Error < ActiveRecord::Base

      self.table_name = 'voltron_defender_errors'

      def name
        "Exception ##{id}"
      end

      def message
        output = []
        output << "*Message:* #{::Slack::Messages::Formatting.unescape(error)}"
        output << "*File:* #{::Slack::Messages::Formatting.unescape(file)}"
        output << "*Line:* #{::Slack::Messages::Formatting.unescape(line)}"
        output.join("\n")
      end

      def http_headers
        JSON.parse(headers) rescue {}
      end

      def in_trello?
        status == 'trello'
      end

    end
  end
end
