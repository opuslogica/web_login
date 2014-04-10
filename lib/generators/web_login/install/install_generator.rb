require 'generators/web_login/helpers'

module WebLogin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include WebLogin::Generators::Helpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Installs WebLogin into the application, creates the routes & configuration necessary to integrate it."

      template "initializer.rb", initializer_path 'web_login.rb'
      inject_into_class application_controller_path , ApplicationController do
        "include WebLogin::ControllerHelpers"
      end

      inject_info_file routes_path, :after => "Application.routes.draw do" do
        "mount WebLogin::Engine"
      end

      def generate_app_files
        template "application.js", "#{javascript_path}/application.js"
        template "app_template.js", "#{javascript_path}/#{app_filename}.js"
      end

      def apply_requirejs
        # copy config file
        copy_file 'requirejs.yml', 'config/requirejs.yml'

        # check if we can find layout file
        # TODO doesn't work during 'destroy' command
        if layout_path
          # inject requirejs tag
          unless gsub_file(layout_path, /javascript_include_tag/, 'requirejs_include_tag')
            display "Can't find a javascript_include_tag in '#{layout_path}'!"
            display "You must add 'requirejs_include_tag' instead of 'javascript_include_tag'"
            display "in your layout(s)."
          end
        else
          display "Can't find a layout to inject requirejs tag!"
          display "You must add 'requirejs_include_tag' instead of 'javascript_include_tag'"
          display "in your layout(s)."
        end
      end


      def post_install_messages
        if File.exists?("#{javascript_path}/application.js")
          display "You have 'application.js' file in your 'assets/' folder."
          display "You should migrate all dependencies to the 'requirejs.yml' config file"
          display "and remove 'application.js file."
        end
      end

    end
  end
end
