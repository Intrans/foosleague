class PlayersController < ApplicationController
  actions :create, :destroy, :new, :show, :index
  belongs_to :league

  def create
    create! { edit_parent_url(:anchor => 'players') }
  end

  def destory
    destroy! { edit_parent_url(:anchor => 'players') }
  end

  private

    def create_resource(object)
      # Check if the player already exists.
      @player = Player.find_by_twitter_name(resource_params[0][:twitter_name].downcase)
      unless @player.present?
        @player = Player.create!(:twitter_name => resource_params[0][:twitter_name].downcase) if object.valid?
      end

      membership = parent.league_memberships.create do |league_membership|
        league_membership.player = @player
      end if @player.valid?

      membership.valid?
    end

    def current_league
      parent
    end

end
