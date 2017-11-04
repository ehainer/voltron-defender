module Voltron
  class Defender
    module Generators
      class InstallGenerator < Rails::Generators::Base

        source_root File.expand_path("../../../templates", __FILE__)

        desc "Add Voltron Defender initializer"

        def inject_initializer

          voltron_initialzer_path = Rails.root.join('config', 'initializers', 'voltron.rb')

          unless File.exist? voltron_initialzer_path
            unless system("cd #{Rails.root.to_s} && rails generate voltron:install")
              puts "Voltron initializer does not exist. Please ensure you have the 'voltron' gem installed and run `rails g voltron:install` to create it"
              return false
            end
          end

          current_initiailzer = File.read voltron_initialzer_path

          unless current_initiailzer.match(Regexp.new(/# === Voltron Defender Configuration ===/))
            inject_into_file(voltron_initialzer_path, after: "Voltron.setup do |config|\n") do
<<-CONTENT

  # === Voltron Defender Configuration ===

  # Whether or not to enable Slack/Trello integration
  # IP restricted detailed error pages are not affected by this setting
  config.defender.enabled = false

  # Slack API token
  config.defender.slack_api_token = ''

  # The Slack channel name in which to report exceptions
  config.defender.slack_channel = ''

  # Trello API key
  config.defender.trello_key = ''

  # Trello API token
  config.defender.trello_token = ''

  # Whether or not to allow showing error details based on IP address
  # If false, the value of Rails.application.config.consider_all_requests_local
  # and the corresponding behavior will always be respected
  config.defender.ip_restrict_errors = true

  # An array of IP addresses or Regexp objects to compare to the REMOTE_ADDR
  # value to determine whether or not to show detailed error messages
  config.defender.ips = []
CONTENT
            end
          end
        end

        def copy_migrations
          copy_migration "create_voltron_defender_errors"
        end

        protected

          def copy_migration(filename)
            if migration_exists?(Rails.root.join("db", "migrate"), filename)
              say_status("skipped", "Migration #{filename}.rb already exists")
            else
              copy_file "db/migrate/#{filename}.rb", Rails.root.join("db", "migrate", "#{migration_number}_#{filename}.rb")
            end
          end

          def migration_exists?(dirname, filename)
            Dir.glob("#{dirname}/[0-9]*_*.rb").grep(/\d+_#{filename}.rb$/).first
          end

          def migration_id_exists?(dirname, id)
            Dir.glob("#{dirname}/#{id}*").length > 0
          end

          def migration_number
            @migration_number ||= Time.now.strftime("%Y%m%d%H%M%S").to_i

            while migration_id_exists?(Rails.root.join("db", "migrate"), @migration_number) do
              @migration_number += 1
            end

            @migration_number
          end
      end
    end
  end
end