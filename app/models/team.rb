class Team < ActiveRecord::Base
  extend FriendlyId
  friendly_id :display_name, use: :slugged

  attr_accessible :name, :logo, :remove_logo, :retained_logo

  has_many :home_games, :foreign_key=>'home_id', :class_name=>'Game'
  has_many :away_games, :foreign_key=>'away_id', :class_name=>'Game'
  has_many :games, :class_name=>'Game', :finder_sql=>'games.home_id = #{id} OR games.away_id = #{id}'
  has_many :memberships, :class_name => 'TeamMembership', :before_add => :set_up_team
  has_many :players, :through => :memberships

  has_one :true_skill, :as=>:subject
  after_create :create_true_skill

  validate :has_players, :on => :create

  belongs_to :league

  image_accessor :logo

  scope :singles, lambda {
    where('player_count = 1')
  }

  scope :doubles, lambda {
    where('player_count = 2')
  }

  scope :with_player, lambda { |player|
    joins("join team_memberships as team_memberships_#{player.id} on team_memberships_#{player.id}.player_id = #{player.id} and team_memberships_#{player.id}.team_id = teams.id")
  }

  scope :by_skill, joins(:true_skill).order('skill desc')

  def display_name
    players.pluck(:name).join(" & ")
  end

  def last_record(max=5)
    wins = 0
    losses = 0

    Game.having_teams(id).order('created_at DESC').limit(max).each do |game|
      wins += 1 if self == game.winner
      losses += 1 if self == game.loser
    end
    return "#{wins}-#{losses}"
  end

  def streak
    games = Game.having_teams(id)
    return "" if games.empty?
    last_games = games.order('created_at DESC')
    last_game = last_games.shift
    last_result = game_result?(last_game)
    streak = 1

    last_games.each do |game|
      if game_result?(game) == last_result
        streak += 1
      else
        break
      end
    end
    return "#{streak} #{last_result.upcase}"
  end

  def to_s
    display_name
  end

  def game_result?(game)
    return "W" if self == game.winner
    return "L" if self == game.loser
  end

  def ratings
    players.map{|u| u.rating }
  end

  def rating
    true_skill.rating
  end

  def skill
    true_skill.skill
  end

  def deviation
    true_skill.deviation
  end

  def update_ratings(updated_ratings)
    players.each_with_index do |player, i|
      rating = updated_ratings[i]
      player.true_skill.update_attributes({:skill=>rating.mean, :deviation=>rating.deviation, :activity=>rating.activity})
    end
  end

  def update_rating(updated_rating)
    true_skill.update_attributes({:skill=>rating.mean, :deviation=>rating.deviation, :activity=>rating.activity})
  end

  private

    def has_players
      errors.add(:players, 'A team must have players') if memberships.empty?
    end

    def set_up_team(membership)
      membership.team = self
    end

end
