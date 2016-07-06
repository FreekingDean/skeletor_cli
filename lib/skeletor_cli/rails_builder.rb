require 'bundler/inline'

module SkeletorCLI
  class RailsBuilder
    def self.build(skeleton, app_name)
      puts `gcc -v`
      gemfile(true) do
        source 'https://rubygems.org'
        gem 'pkg-config'
        gem 'rails', skeleton[:gems][:rails][:version]
      end
      Rails::Generators::AppGenerator.start [app_name]
    end
  end
end
