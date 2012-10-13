class LeaguesController < ApplicationController
  actions :create, :edit, :index, :new, :update


  def create
    create! { resource_url }
  end

  def update
    update! { resource_url }
  end

  protected

    def current_league
      [ 'index' ].include?(action_name) ? super : resource
    end

    def begin_of_association_chain
      current_player
    end

    def league_menu_label
      return 'New League' if action_name == 'new'
      [ 'index' ].include?(action_name) ? 'League Menu' : resource.name
    end

end
