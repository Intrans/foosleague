Foosleague::Application.routes.draw do
  devise_for :players
  root :to => Stationary::Engine
  match '/:path(.:format)', :to => Stationary::Engine, :constraints => { :path => /.+?/ }
end
