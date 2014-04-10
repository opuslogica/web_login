module WebLogin
  class SessionsController < WebLoginController
    def sign_in
      @return_to = session[WebLogin::Config.session_key_for_redirect_target]
      @params = params

      if(params[:commit])
        @user_object = instance_eval(&WebLogin::Config.authenticate_with)
        WebLogin.set_authenticated(session,@user_object)

        if(@user_object) 
          redirect_to session[WebLogin::Config.session_key_for_redirect_target] || '/'
        else
          flash[:error] = "Incorrect credentials."
        end
      else
        
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
        instance_eval(&sign_up_with) 
      else
        flash[:error] = "No sign up callback"
      end
    end
  end
end
