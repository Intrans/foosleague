class GamesController < InheritedResources::Base
  actions :create, :index, :new, :show
  belongs_to :league
  respond_to :html, :json
end
