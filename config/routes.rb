Foosleague::Application.routes.draw do
  devise_for :players, :path_names => {sign_in: "login", sign_out: "logout"},
                       :controllers => {:sessions => "sessions", :registrations => 'registrations', :passwords => 'passwords', :omniauth_callbacks => "omniauth_callbacks"}

  root :to => Stationary::Engine
  match '/:path(.:format)', :to => Stationary::Engine, :constraints => { :path => /.+?/ }
end
