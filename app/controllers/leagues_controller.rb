class LeaguesController < ApplicationController
  actions :create, :edit, :index, :new, :update


  def create
    create! { resource_url }
  end

  def update
    update! { resource_url }
  end

  protected

    def begin_of_association_chain
      current_player
    end

    def build_resouce
      super
      3.times { resource.league_memberships.build } if action_name == 'new'
    end

    def current_league
      [ 'index' ].include?(action_name) ? super : resource
    end

    def league_menu_label
      return 'New League' if [ 'create', 'new' ].include?(action_name)
      [ 'index' ].include?(action_name) ? 'League Menu' : resource.name
    end

end
