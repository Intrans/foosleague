Foosleague::Application.routes.draw do
  root :to => Stationary::Engine
  match '/:path(.:format)', :to => Stationary::Engine, :constraints => { :path => /.+?/ }
end
