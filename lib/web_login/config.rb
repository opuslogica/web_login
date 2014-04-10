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
      split = session_data.split("$$")
      model_name = split[0]
      model_id = split[1]
      model_name.constantize.find(model_id)
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

      def session_key_for_redirect_target
        :web_login_finished_redirect_location
      end
      
    end
  end
end
