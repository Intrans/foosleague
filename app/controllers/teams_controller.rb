class TeamsController < ApplicationController
  actions :edit, :index, :update
  belongs_to :league
  respond_to :html, :json

  def create
    create! { parent_url }
  end

  protected

    def begin_of_association_chain
      current_player
    end

end

