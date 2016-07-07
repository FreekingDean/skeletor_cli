require 'bundler/inline'

module SkeletorCLI
  class RailsBuilder
    def self.build(skeleton, app_name)
      gemfile(true) do
        source 'https://rubygems.org'
        gem 'railties', skeleton[:gems][:rails][:version]
      end
      require 'rails/generators'
      require 'rails/generators/rails/app/app_generator'
      args = [app_name]
      Rails::Generators::AppGenerator.start args
    end
  end
end
