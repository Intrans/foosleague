class PlayersController < ApplicationController
  actions :create, :new
  belongs_to :league

  def create
    create! { parent_url }
  end

end
