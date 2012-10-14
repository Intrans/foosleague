Foosleague::Application.routes.draw do
  devise_for :players, :path_names => {sign_in: "login", sign_out: "logout"},
                       :controllers => {:sessions => "sessions", :registrations => 'registrations', :passwords => 'passwords', :omniauth_callbacks => "omniauth_callbacks"}

  authenticated :player do
    resources :leagues, :only => [ :create, :edit, :new, :show, :update ] do
      resources :games
      resources :players, :only => [ :create, :destroy, :new ]
      resources :teams, :only => [ :edit, :update ]
    end
    match "/leagues" => redirect("/")
    root :to => "leagues#index"
  end

  root :to => Stationary::Engine
  match '/:path(.:format)', :to => Stationary::Engine, :constraints => { :path => /.+?/ }
end
