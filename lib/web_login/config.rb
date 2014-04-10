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
      def authenticate_with(&blk)
        @authenticate = blk if blk
        @authenticate || DEFAULT_AUTHENTICATION
      end

      def sign_up_with(&blk)
        @signup = blk if blk
        @signup
      end


      def model=(model)
        @credential_model = model
      end

      def model
        @credential_model
      end
      
      def sessionize_with(&blk)
        @sessionize = blk if blk
        @sessionize || DEFAULT_SESSIONIZE
      end

      def desessionize_with(&blk)
        @desessionize = blk if blk
        @desessionize || DEFAULT_DESESSIONIZE
      end

      def session_key=(key)
        @session_key = key
      end
      def session_key
        @session_key || :user_id
      end

      def post_sign_out_url=(url)
        @post_sign_out_url = url
      end
      def post_sign_out_url
        @post_sign_out_url || '/'
      end
      
    end
  end
end
