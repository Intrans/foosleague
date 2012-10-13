class PlayersController < ApplicationController
  actions :create, :new
  belongs_to :league

  def create
    create! { parent_url }
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
end
