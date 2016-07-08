require 'bundler/inline'

module SkeletorCLI
  class RailsBuilder
    def self.build(skeleton, app_name)
      gemfile(true) do
        source 'https://rubygems.org'
        if skeleton[:gems][:rails][:version].nil? || skeleton[:gems][:rails][:version] == ''
          gem 'rails'
        else
          gem 'rails', skeleton[:gems][:rails][:version]
        end
      end
      require 'rails/generators'
      require 'rails/generators/rails/app/app_generator'
      template_file = template(skeleton, app_name)
      args = [app_name, "--database=#{skeleton[:database]}", "--template=#{template_file.path}"]
      Rails::Generators::AppGenerator.start args
      template_file.unlink
    end

    def self.template(skeleton, app_name)
      file = Tempfile.new('skeletor_rails_template')
      file.write <<-TEMPLATE
create_file '.ruby-gemset', #{'<<-GEMSET'}
  #{app_name}
GEMSET
run "rm Gemfile && touch Gemfile"
add_source 'https://rubygems.org'
#{skeleton[:gems].map do |gem_name, metadata|
"gem '#{gem_name}'#{metadata[:version] == '' || metadata[:version].nil? ? '' : ", '#{metadata[:version]}'"}"
end.join("\n")}
      TEMPLATE
      file.close
      file
    end
  end
end
