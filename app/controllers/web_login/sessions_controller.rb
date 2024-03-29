module WebLogin
  class SessionsController < WebLoginController
    def finish
      WebLogin.set_authenticated(session, @user_object)

      if (@user_object) 
        redirect_to session[WebLogin::Config.session_key_for_redirect_target] || '/'
      else
        flash.now[:error] = "Incorrect credentials."
      end
    end
      
    def sign_in
      @return_to = session[WebLogin::Config.session_key_for_redirect_target]
      @params = params

      if (params[:commit])
        @user_object = instance_eval(&WebLogin::Config.authenticate_with)
        finish
      end
    end

    def sign_out
      WebLogin.set_authenticated(session,nil)
      redirect_to WebLogin::Config.post_sign_out_url
    end
    
    def sign_up
      @params = params
      sign_up_with = WebLogin::Config.sign_up_with
      
      if sign_up_with
        if params.has_key?(:login) && params.has_key?(:password)
          @user_object = instance_eval(&sign_up_with) 
        else
          return
        end
      else
        flash.now[:error] = "No sign up callback"
      end

      finish
    end

    def omniauth
      @provider = params[:provider]
      @auth = request.env['omniauth.auth']
      
      @uid = @auth[:uid]
      @email = @auth[:info][:email]
      @email = @email.downcase if @email.present?
      
      omniauth_with = WebLogin::Config.omniauth_with

      if omniauth_with
        @user_object = instance_eval(&omniauth_with)
      else
        flash.now[:error] = "No omniauth callback"
      end

      finish
    end
  end
end
