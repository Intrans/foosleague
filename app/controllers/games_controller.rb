class GamesController < InheritedResources::Base
  actions :create, :index, :new, :show
  belongs_to :league
  respond_to :html, :json

  protected

    def begin_of_association_chain
      current_player
    end

end
