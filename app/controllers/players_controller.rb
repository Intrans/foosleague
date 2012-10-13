class PlayersController < InheritedResources::Base
  actions :create, :new
  belongs_to :league

  def create
    create! { parent_url }
  end

  private

    def create_resource(object)
      # Check if the user already exists.
      @player = Player.find_by_twitter_name(resource_params[0][:twitter_name].downcase)
      if @player.present?
        membership = @league.league_memberships.create(:player => @player)
        return true if membership.valid?
        @player = object
        return false
      end

      # # Invite the user if they do not.
      @player = Player.create!(:twitter_name => resource_params[0][:twitter_name].downcase) if object.valid?
      membership = @league.league_memberships.create(:player => @player) if @player.valid?
      @player.valid?
    end
end
