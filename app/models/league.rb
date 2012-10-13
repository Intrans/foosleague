class League < ActiveRecord::Base
  attr_accessible :doubles, :name

  has_many :league_memberships, :inverse_of => :league
  has_many :players, :through => :league_memberships, :inverse_of => :leagues
  has_many :games

  has_many :teams do
    def find_or_create_by_players(players)
      # force into and array if needed
      players = [players] unless Array === players

      team = if players.size > 1
        proxy_association.owner.teams.with_player(players.first).with_player(players.last).first
      else
        proxy_association.owner.teams.singles.with_player(players.first).first
      end

      return team if team.present? # return the team if it already exists

      team = proxy_association.owner.teams.new do |team|
        players.each do |player|
          team.memberships.build do |membership|
            membership.player = player
          end
        end
      end
      logger.info team.valid?
      logger.info team.inspect
      logger.info team.errors.inspect
      logger.info team.save
      team
    end
  end

  def required_number_of_players
    doubles? ? 2 : 1
  end

end
