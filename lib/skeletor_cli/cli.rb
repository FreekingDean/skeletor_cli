require 'yaml'
require 'thor'
require 'skeletor_api'

module SkeletorCLI
  class CLI < Thor
    DEFAULT_CONFIG = ".skeletor"
    class_option :config

    def initialize(*args)
      super(*args)
      find_or_init_config
    end

    desc 'build SLUG APP_NAME', 'build the app from the specified skeleton'
    def build(slug, app_name)
      skeleton = @api_client.get_skeleton(slug)
      RailsBuilder.build(skeleton, app_name)
    end

    private
    def find_or_init_config
      @config_file = options[:config] || File.join(ENV.fetch('HOME'), "#{DEFAULT_CONFIG}")
      unless options[:config].nil? || File.exist?(options[:config])
        puts "Could find config directory: #{options[:config_dir]}"
        exit(1)
      end
      File.open(@config_file, 'w') {|f| f.write("api_key:\n")} unless File.exist?(@config_file)
      @config = YAML.load_file(@config_file)
      unless @config && @config['api_key'] && !@config['api_key'].empty?
        puts "Could not find api key. Please add it to #{@config_file}"
        exit(1)
      end
      SkeletorApi.configure do |config|
        config.api_key = @config['api_key']
      end
      @api_client = SkeletorApi::Client.new
    end
  end
end
