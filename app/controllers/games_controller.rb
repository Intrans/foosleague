class GamesController < ApplicationController
  actions :create, :index, :new, :show
  belongs_to :league
  respond_to :html, :json

  helper_method :curent_league

  def create
    create! { parent_url }
  end

  protected

    def begin_of_association_chain
      current_player
    end

    def current_league
      parent
    end

end
