module Voltron
  class Config

    def defender
      @defender ||= Defender.new
    end

    class Defender

      attr_accessor :enabled, :slack_api_token, :slack_channel, :trello_key, :trello_token, :trello_board, :ip_restrict_errors, :ips

      def initialize
        @enabled ||= false
        @ip_restrict_errors ||= true
        @ips ||= []
      end

      def enabled?
        enabled == true
      end

      def has_ip?(ip)
        return false if ip.blank?

        candidates = [ips].flatten.compact
        
        candidates.each do |candidate|
          if candidate.is_a?(Regexp)
            return true if candidate =~ ip.to_s
          else
            return true if candidate.to_s == ip.to_s
          end
        end

        false
      end

    end
  end
end
