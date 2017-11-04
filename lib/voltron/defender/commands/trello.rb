require 'voltron/defender/command'

module Voltron
  class Defender
    class Trello < Command

      def help
        "# Create a Trello card for the most recent exception, or the specific exception if an id is provided\n.trello [id] [lane]\n"
      end

      def answer(text, adapter)
        adapter.message('One second, I\'m working on it...')
        lane, is_new = find_or_create_lane(text)
        card = add_card(lane)
        if is_new
          adapter.message("Okay, I created the lane `#{lane.name}` and added the card for #{error.name.downcase} to it. #{card.short_url}")
        else
          adapter.message("Okay, I've added the card for #{error.name.downcase} to the `#{lane.name}` lane. #{card.short_url}")
        end
      end

      def responds_to
        ['trello']
      end

      def add_card(lane)
        File.open("trace-#{error.id}.log", 'w+') { |f| f.write(error.trace) }
        File.open("headers-#{error.id}.log", 'w+') { |f| error.http_headers.each { |h,v| f.write("#{h}: #{v}\n") } }
        
        card = ::Trello::Card.create(name: error.name, desc: error.error, list_id: lane.id)
        card.add_attachment(File.open("trace-#{error.id}.log", 'r'), 'Stack Trace')
        card.add_attachment(File.open("headers-#{error.id}.log", 'r'), 'HTTP Headers')

        error.update(status: :trello)
        card
      end

      def find_or_create_lane(name)
        lane = trello.lane(name)
        if lane.blank?
          lane = ::Trello::List.create(name: name, board_id: trello.board.id)
          [lane, true]
        else
          [lane, false]
        end
      end

      def respond_with(adapter)
        if error
          if error.in_trello? && !args.include?('-f')
            adapter.message("My records indicate that a card for #{error.name.downcase} was already created. If you want to create it anyways, use `.trello #{error.id} #{args.length > 0 ? args.join(' ') + ' ' : ''}-f`")
          else
            params = args.reject { |a| a == '-f' }
            if params.length > 0
              answer(params.join(' '), adapter)
            else
              adapter.message('One second, I\'m getting a list of Trello lanes...')
              adapter.ask("What lane should I add the card to? If you specify something not in this list I'll create it for you. ```#{trello.lanes.join("\n")}```", self)
            end
          end
        else
          adapter.message('Sorry, I wasn\'t able to find any exception to provide information on. Try specifying an exception id, like `.<command> <id>`')
        end
      end

      private

        def trello
          @trello ||= ::Voltron::Defender::TrelloAdapter.new
        end

    end
  end
end