require "omniauth"
require "omniauth-facebook"

module WebLogin
  module Config
    DEFAULT_AUTHENTICATION = proc { logger.info "Default authenticator does nothing..."; nil }
    DEFAULT_SESSIONIZE = proc { |user_model|
      if user_model
        model_name = user_model.class.name
        model_id = user_model.id rescue nil
        "#{model_name}$$#{model_id}"
      else
        ""
      end
    }

    DEFAULT_DESESSIONIZE = proc { |session_data| 
      split = session_data.split("$$") if session_data
      model_name = split[0] if split
      model_id = split[1] if split
      puts "Finding #{model_name}/#{model_id}"
      model_name.constantize.find(model_id) if model_name && model_id
    }

    class << self
      # Set the authentication callback, which by default does
      # nothing.
      def authenticate_with(&blk)
        @authenticate = blk if blk
        @authenticate || DEFAULT_AUTHENTICATION
      end

      # Set the sign up callback, which by default does not exist.
      def sign_up_with(&blk)
        @signup = blk if blk
        @signup
      end

      # Set the omniauth callback, which by default does not exist
      def omniauth_with(&blk)
        @omniauth_cb = blk if blk
        @omniauth_cb
      end

      # Set the callback by which referenced credentials are stored in
      # the session.  By default, they are treated as ActiveRecord
      # objects.
      def sessionize_with(&blk)
        @sessionize = blk if blk
        @sessionize || DEFAULT_SESSIONIZE
      end

      # Set the callback by which referenced credentials are
      # instantiated from the session.  By default, they are treated
      # as ActiveRecord objects.
      def desessionize_with(&blk)
        @desessionize = blk if blk
        @desessionize || DEFAULT_DESESSIONIZE
      end

      # Set the session key under which the credentials are stored in
      # the session.
      def session_key=(key)
        @session_key = key
      end
      def session_key
        @session_key || :user_id
      end

      # Set the URL where freshly signed out users are redirected to.
      # By default, they go to the root of the site.
      def post_sign_out_url=(url)
        @post_sign_out_url = url
      end
      def post_sign_out_url
        @post_sign_out_url || '/'
      end
      
      # Set the URL where freshly signed IN users are redirected to.
      # By default, they go to the root of the site. or can be directed
      # by WebLogin::Config.session_key_for_redirect_target
      def post_sign_in_url=(url)
        @post_sign_in_url = url
      end
      def post_sign_in_url
        @post_sign_in_url || '/'
      end
      # Set the URL where freshly signed UP users are redirected to.
      # By default, they go to the root of the site. or can be directed
      # by WebLogin::Config.session_key_for_redirect_target      
      def post_sign_up_url=(url)
        @post_sign_up_url = url
      end
      def post_sign_up_url
        @post_sign_up_url || '/'
      end
      # Set the URL where freshly signed IN/UP via Facebook (or other) users are redirected to.
      # By default, they go to the root of the site. or can be directed
      # by WebLogin::Config.session_key_for_redirect_target
      def post_platform_sign_in_url=url
        @post_platform_sign_in_url = url
      end      
      def post_platform_sign_in_url
        @post_platform_sign_in_url || '/'
      end      
      
      def session_key_for_redirect_target
        :web_login_finished_redirect_location
      end
      
      def use_facebook(hash)
        @using_facebook = true
        Rails.application.config.middleware.use OmniAuth::Builder do
          provider :facebook, hash[:app_id], hash[:app_secret], hash
        end
      end

      def use_facebook?
        @using_facebook
      end
    end
  end
end
