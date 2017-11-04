require 'trello'

module Voltron
  class Defender
    class TrelloAdapter

      def initialize
        ::Trello.configure do |config|
          config.developer_public_key = Voltron.config.defender.trello_key
          config.member_token = Voltron.config.defender.trello_token
        end
      end

      def has_lane?(name)
        lane.present?
      end

      def lane(name)
        board.lists.find { |list| list.name.downcase == name.downcase }
      end

      def lanes
        board.lists.map(&:name)
      end

      def board
        @board ||= ::Trello::Board.find(Voltron.config.defender.trello_board)
      end

    end
  end
end