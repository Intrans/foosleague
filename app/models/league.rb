class League < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :doubles, :logo, :name, :players, :remove_logo, :retained_logo

  has_many :league_memberships, :inverse_of => :league
  has_many :players, :through => :league_memberships, :inverse_of => :leagues
  accepts_nested_attributes_for :players
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
      team
    end
  end

  image_accessor :logo

  normalize_attributes :name

  validates :name,
    :presence => true

  def to_s
    name
  end

  def required_number_of_players
    doubles? ? 2 : 1
  end

end
