require 'generators/web_login/helpers'

module WebLogin
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include WebLogin::Generators::Helpers

      source_root File.expand_path("../templates", __FILE__)

      desc "Installs WebLogin into the application, creates the routes & configuration necessary to integrate it."

      def create_initializer
        template "initializer.rb", File.join('config','initializers','web_login.rb')
      end
      
      def update_app_controller
        inject_into_class application_controller_path , ApplicationController do
          "  include WebLogin::ControllerHelpers\n"
        end
      end

      def mount_engine
        inject_into_file routes_path, :after => "Application.routes.draw do\n" do
          "  mount WebLogin::Engine => '/authentication' \n"
        end
      end

    end
  end
end
