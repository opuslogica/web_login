require "web_login/version"
require "web_login/engine"
require "web_login/config"
require "web_login/controller_helpers"

module WebLogin
  def self.set_authenticated(session,object)
    session[WebLogin::Config.session_key] = WebLogin::Config.sessionize_with.call(object)
  end

  def self.get_authenticated(session)
    WebLogin::Config.desessionize_with.call(session[WebLogin::Config.session_key])
  end
  
  def self.config(&block)
    if block
      block.call(WebLogin::Config)
    else
      WebLogin::Config
    end
  end
end
