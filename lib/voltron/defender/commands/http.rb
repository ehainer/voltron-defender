require 'voltron/defender/command'

module Voltron
  class Defender
    class Http < Command

      def help
        "# Fetch specific HTTP headers, or all headers if no header names are provided\n.http|.head|.header|.headers [id] [header name] [header name] ...\n"
      end

      def responds_to
        ['http', 'head', 'header', 'headers']
      end

      def respond_with(adapter)
        if error
          if args.length > 0
            found = []
            missing = []
            headers = error.http_headers
            args.each do |arg|
              if headers.has_key?(arg.upcase)
                found << "#{arg.upcase}: #{headers[arg.upcase].to_s.gsub('%', '%%')}"
              else
                missing << arg.upcase
              end
            end

            if found.length > 0 && missing.length == 0
              adapter.message("Here's what I found ```#{found.join("\n")}```")
            elsif found.length > 0 && missing.length > 0
              adapter.message("Below are the HTTP headers I managed to find. I wasn't able to find headers with the name `#{missing.to_sentence(words_connector: '`, `', two_words_connector: '` or `', last_word_connector: '`, or `')}` ```#{found.join("\n")}```")
            elsif found.length == 0 && missing.length > 0
              adapter.message("I couldn't find HTTP headers matching `#{missing.to_sentence(words_connector: '`, `', two_words_connector: '` or `', last_word_connector: '`, or `')}`")
            end
          else
            output = error.http_headers.map { |k,v| "#{k}: #{v.to_s.gsub('%', '%%')}" }.join("\n")
            adapter.message("Here's all the headers that were present when #{error.name.downcase} happened ```#{output}```")
          end
        else
          adapter.message('Sorry, I wasn\'t able to find any exception to provide information on. Try specifying an exception id, like `.<command> <id>`')
        end
      end

    end
  end
end