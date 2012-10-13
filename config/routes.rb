Foosleague::Application.routes.draw do
  devise_for :players, :controllers => {:sessions => "sessions", :registrations => 'registrations', :passwords => 'passwords'}

  devise_scope :player do
    get "login" => "sessions#new", :as => 'new_player_session'
    get "logout" => "sessions#destroy", :as => 'destroy_player_session'
    get "signup" => "registrations#new", :as => 'new_player_registration'
  end
  
  root :to => Stationary::Engine
  match '/:path(.:format)', :to => Stationary::Engine, :constraints => { :path => /.+?/ }
end
