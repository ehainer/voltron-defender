require 'voltron'
require 'tempfile'
require 'voltron/defender/version'
require 'voltron/config/defender'
require 'voltron/defender/slack_adapter'
require 'voltron/defender/trello_adapter'
require 'voltron/defender/commands/when'
require 'voltron/defender/commands/trace'
require 'voltron/defender/commands/http'
require 'voltron/defender/commands/trello'
require 'voltron/defender/commands/help'
require 'voltron/defender/commands/stop'
require 'voltron/defender/commands/defender'

module Voltron
  class Defender

    def initialize(app)
      @app = app

      @slack = ::Voltron::Defender::SlackAdapter.new

      @slack.commander.listen_to(::Voltron::Defender::When)
      @slack.commander.listen_to(::Voltron::Defender::Trace)
      @slack.commander.listen_to(::Voltron::Defender::Http)
      @slack.commander.listen_to(::Voltron::Defender::Trello)
      @slack.commander.listen_to(::Voltron::Defender::Stop)
      @slack.commander.listen_to(::Voltron::Defender::Help)
      @slack.commander.listen_to(::Voltron::Defender::Defender)
    end

    def call(env)
      begin
        @app.call(env)
      rescue Exception => e
        if Voltron.config.defender.enabled?
          error = Voltron::Defender::Error.new(exception_params(e, env))
          handle(error) if error.save
        end

        if Voltron.config.defender.ip_restrict_errors
          if Voltron.config.defender.has_ip?(env.try(:[], 'REMOTE_ADDR'))
            env['action_dispatch.show_detailed_exceptions'] = true
          end
        end
        raise e
      end
    end

    def handle(error)
      @slack.client.start_async unless @slack.client.started?

      if @slack.client.started?
        @slack.attach(error.name, error.message, :danger)
      end
    end

    private

      def exception_params(ex, env)
        last_line = (ex.backtrace.first || 'Unknown:Unknown').split(':')
        headers = (env ||= {}).select { |k,v| /^[A-Z_]+$/.match(k.to_s) }

        { error: ex.message, file: last_line[0], line: last_line[1], trace: ex.backtrace.join("\n"), headers: headers.to_json }
      end

  end
end

require "voltron/defender/engine" if defined?(Rails)