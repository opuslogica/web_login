module WebLogin
  module ControllerHelpers
    def get_authenticated_from_session
      authenticated = nil

      session_value = session[WebLogin::Config.session_key]
      logger.info "Got session value #{session_value}"
      begin
        authenticated = WebLogin::Config.desessionize_with.call(session_value)
      rescue => e
        logger.error e
      end

      authenticated
    end

    def set_session_from_authenticated
      session_value = WebLogin::config.sessionize_with.call(authenticated)
      logger.info "Settings session value to be #{session_value}"
      session[WebLogin::Config.session_key] = session_value
    end
    
    def authenticated
      @___authenticated ||= get_authenticated_from_session
      @___authenticated || nil
    end

    def authenticated?
      (self.authenticated != nil)
    end
    
    def authenticate!
      redirect_to web_login.sign_in_url unless self.authenticated?
    end

    def authenticated=(user)
      @___authenticated = user
      set_session_from_authenticated user
    end
  end
end
