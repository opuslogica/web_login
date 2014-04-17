WebLogin::Engine.routes.draw do
  # routes we'll need,
  match "sign_in" => "web_login/sessions#sign_in" , as: :sign_in, via: [:get , :post]
  get "sign_out" => "web_login/sessions#sign_out", as: :sign_out
  match "sign_up" => "web_login/sessions#sign_up", as: :sign_up, via: [:get,:post]
end

Rails.application.routes.draw do
  get "auth/:provider/callback" => "web_login/sessions#omniauth"
end
