require 'bundler/inline'

module SkeletorCLI
  class RailsBuilder
    def self.build(skeleton, app_name)
      gemfile(true) do
        source 'https://rubygems.org'
        if skeleton[:gems][:rails][:version].nil?
          gem 'rails'
        else
          gem 'rails', skeleton[:gems][:rails][:version]
        end
      end
      require 'rails/generators'
      require 'rails/generators/rails/app/app_generator'
      args = [app_name, "--database=#{skeleton[:database]}"]
      Rails::Generators::AppGenerator.start args
    end
  end
end
