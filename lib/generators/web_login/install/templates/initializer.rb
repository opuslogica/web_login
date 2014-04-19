WebLogin.config do |config|
  config.authenticate_with do
    # authenticate_with is the callback that is used to see if the
    # user is actually authenticated.  If the user is authenticated,
    # please return from this method an object that represents the
    # authenticated identity.  If the user is not authenticated,
    # return nil.
    # 
    # In authenticate_with, you are run within the context of the
    # SessionsController that handles the forms for signing in.  You
    # can access the parameters passed by the form with the @params
    # hash.  You can override the form's appearance with the view at
    #
    # app/views/web_login/sessions/sign_in.html.erb
    #
    # For our purposes, we assume there is a Credential type, that
    # responds to the class method authenticate.
    
    Credential.authenticate(@params[:login],@params[:password])
  end

  config.sign_up_with do
    # sign_up_with is the callback that is used to create
    # authenticated identies based on user input.  If this callback is
    # not defined, the user is not presented with the option of
    # signing up.
    #
    # Similar to authenticate_with, you are given access to the
    # parameters of the form, through @params, and can override the
    # form with the view at
    #
    # app/views/web_login/sessions/sign_up.html.erb
    # 
    # For our purposes, we will assume that a Credential object can be
    # created with an email and a password.
    
    Credential.sign_up(@params[:login],@params[:password])
  end

  # You may also elect to use OmniAuth to allow for user sign in and
  # sign up.  To connect these dots, you must add a glue-function to
  # connect to whatever authentication package you are using.

  config.omniauth_with do
    Credential.authenticate_oauth(:email => @email, :provider => @provider, :uid => @uid)
  end

  # Built-in support for facebook requires that you simply add in the
  # app ID and app secret for your app:
  # config.use_facebook app_id: '<APP_ID>', app_secret: '<APP SECRET>'

  # Other options:
  #
  # You may read about the other options in lib/web_login/config.rb
  #
  # Examples include callbacks to customize the sessionization and
  # de-sessionization of credential objects (they are by default
  # treated as ActiveRecord objects).  Post-sign-out destinations,
  # etc.
end
