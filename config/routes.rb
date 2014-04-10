Rails.application.routes.draw do
  # routes we'll need,
  namespace :web_login , :path => "/authentication" do
    match "sign_in" => "sessions#sign_in" , as: :sign_in, via: [:get , :post]
    get "sign_out" => "sessions#sign_out", as: :sign_out
    match "sign_up" => "sessions#sign_up", as: :sign_up, via: [:get,:post]
  end
end
