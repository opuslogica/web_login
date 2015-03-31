module WebLogin
  class SessionsController < WebLoginController
    layout WebLogin::Config.layout
    
    def finish
      WebLogin.set_authenticated(session, @user_object)

      if (@user_object) 
        redirect_to session[WebLogin::Config.session_key_for_redirect_target] || '/'
      #else
        #flash[:error] = "Incorrect credentials."
      end
    end
      
    def sign_in        
      if WebLogin.get_authenticated(session)
        redirect_to session[WebLogin::Config.session_key_for_redirect_target]
      end
        
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
      if WebLogin.get_authenticated(session)
        redirect_to session[WebLogin::Config.session_key_for_redirect_target]
      end
      
      @user_object = nil
      @params = params
      @user_object = nil
      #basic validation here so we dont have to do it in the apps
      if !params["login"].blank? && !params["password"].blank? && !params["password_confirm"].blank?
        if params["password"] != params["password_confirm"]
          flash[:error] = "Your passwords do not match"
        else          
          sign_up_with = WebLogin::Config.sign_up_with
      
          if sign_up_with
            @results = instance_eval(&sign_up_with) 
            if @results[0].nil?
              flash[:error] = @results[1]
            else
              @user_object = @results[0]
            end
          else
            flash[:error] = "No sign up callback"
          end
        end
        finish
      end
    end

    def omniauth
      @user_object = nil
      @provider = params[:provider]
      @auth = request.env['omniauth.auth']
      
      @uid = @auth[:uid]
      @email = @auth[:info][:email]
      @name  = @auth[:info][:name]
      @email = @email.downcase if @email.present?
      
      omniauth_with = WebLogin::Config.omniauth_with

      if omniauth_with
        @results = instance_eval(&omniauth_with)
        if @results[0].nil?
          flash[:error] = @results[1]
        else
          @user_object = @results[0]
        end
      else
        flash[:error] = "No omniauth callback"
      end
      if !@user_object
        render 'sign_in'
      else
        finish
      end
    end
  end
end
