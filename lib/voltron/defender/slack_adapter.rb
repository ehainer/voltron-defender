require 'slack'
require 'voltron/defender/commander'

module Voltron
  class Defender
    class SlackAdapter

      attr_accessor :questioned, :asker

      def initialize
        client.on(:message) { |message| message_received(message) }
        client.on(:close) { socket_closed }
      end

      def message_received(message)
        # The bot is the user that posted the message, ignore whatever it said
        return if client.self.id == message.user

        nvm if is_command?(message.text)

        if waiting?
          client.typing channel: channel
          asker.answer(message.text, self)
          nvm
        elsif commander.matches?(message.text)
          client.typing channel: channel
          commander.processor(message.text).respond_with(self)
        end
      end

      def socket_closed
        message "Connection has been closed, I'm no longer listening for commands"
      end

      def ask(question, asker, **args)
        @questioned = true
        @asker = asker
        message(question, args)
      end

      def nvm
        @questioned = false
        @asker = nil
      end

      def attach(title=nil, text=nil, color=nil, **args)
        payload = { pretext: title, color: color, text: text, mrkdwn_in: ['text', 'pretext'] }.compact.merge(args)
        client.web_client.chat_postMessage channel: channel, attachments: [payload].to_json, as_user: true
      end

      def message(text, **args)
        client.web_client.chat_postMessage channel: channel, text: (text % args), mrkdwn: true, as_user: true
      end

      def upload(name, title, content)
        client.web_client.files_upload channels: channel, filename: name, title: title, content: content, as_user: true
      end

      def commander
        @commander ||= ::Voltron::Defender::Commander.new
      end

      def waiting?
        questioned == true
      end

      def is_command?(text)
        text.to_s.strip.starts_with?('.')
      end

      def client
        @client ||= ::Slack::RealTime::Client.new(token: Voltron.config.defender.slack_api_token, timeout: 10, open_timeout: 15)
      end

      private

        def channel
          '#' + Voltron.config.defender.slack_channel.to_s.gsub(/[^a-z0-9\-]/i, '')
        end

    end
  end
end