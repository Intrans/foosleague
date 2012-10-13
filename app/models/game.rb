class Game < ActiveRecord::Base
  include Saulabs

  attr_accessible :away_id, :away_score, :completed_at, :home_id, :home_score, :league_id
  attr_accessor :home_team_players, :away_team_players

  belongs_to :home, :class_name => 'Team'
  belongs_to :away, :class_name => 'Team'
  belongs_to :league

  has_many :game_logs

  scope :completed, where('completed_at is not null')
  scope :incomplete, where('completed_at is null')

  scope :recent, proc { |record_limit|
    record_limit ||= 50
    limit(record_limit).
    order('created_at DESC')
  }

  scope :having_teams, lambda {|team_ids| where(['home_id in (?) or away_id in (?)', team_ids, team_ids])}

  after_create :create_game_start_log
  after_create :complete_if_has_scores
  before_validation :create_teams, :on => :create
  before_destroy :lastest_league_game?
  after_destroy :revert_foos_skills
  validate :correct_players?
  validate :score_is_legit?

  validates_presence_of :away, :home, :league

  scope :wins,  lambda {|team_ids| where("home_id in (?) AND home_score > away_score OR away_id in (?) AND away_score > home_score", team_ids, team_ids)}
  scope :loses, lambda {|team_ids| where("home_id in (?) AND home_score < away_score OR away_id in (?) AND away_score < home_score", team_ids, team_ids)}

  def score_is_legit?
    errors.add(:base, "one team must reach 10 goals") and return unless home_score >= 10 || away_score >= 10
    errors.add(:base, "you have to win by 2") and return unless (home_score-away_score).abs >= 2
    errors.add(:base, "you can't win by more than 10") and return unless (home_score-away_score).abs <= 10
  end

  def correct_players?
    errors.add(:base, "2 player on each side") and return unless home.player_ids.count == 2 && away.player_ids.count == 2
  end

  def revert_foos_skills
    transaction do
      # revert team foos skills
      home_skill = home.true_skill.previous_version
      home_skill.without_versioning :save

      away_skill = away.true_skill.previous_version
      away_skill.without_versioning :save

      # revert player foos skills
      (away_team_players + home_team_players).each do |user|
        skill = user.true_skill.previous_version
        skill.without_versioning :save
      end

      # revert LeagueUser foos skills
      league.memberships.where(['player_id in (?)', home.player_ids]).each do |membership|
        skill = membership.true_skill.previous_version
        skill.without_versioning :save
      end

      # revert LeagueUser foos skills
      league.memberships.where(['player_id in (?)', away.player_ids]).each do |membership|
        skill = membership.true_skill.previous_version
        skill.without_versioning :save
      end
    end
  end

  def lastest_league_game?
    if self != league.games.last
      errors.add :base, "Can only delete latest league game"
      return false
    end
  end

  def completed?
    completed_at
  end

  def away_team_players
    return away.players if away.present?
    return [] unless @away_team_players.present?
    @away_team_players = if Array === @away_team_players
      @away_team_players.map { |player| (User === player) ? player : league.players.find(player) }
    else
      []
    end
  end

  def home_team_players
    return home.players if home.present?
    return [] unless @home_team_players.present?
    @home_team_players = if Array === @home_team_players
      @home_team_players.map { |player| (User === player) ? player : league.players.find(player) }
    else
      []
    end
  end

  def complete!
    throw "match already complete" unless self.completed_at.nil?
    self.completed_at = Time.now

    graph = TrueSkill::FactorGraph.new([winner.ratings, loser.ratings], [1,2])
    graph.update_skills

    winner.update_ratings(graph.teams.first)
    loser.update_ratings(graph.teams.last)

    team_graph = TrueSkill::FactorGraph.new([[winner.rating],[loser.rating]], [1,2])
    team_graph.update_skills

    winner.update_rating(team_graph.teams.first.first)
    loser.update_rating(team_graph.teams.last.first)

    league_winners = league.memberships.where(['player_id in (?)', winner.player_ids])
    league_losers = league.memberships.where(['player_id in (?)', loser.player_ids])

    league_graph = TrueSkill::FactorGraph.new([league_winners.map{|m| m.rating}, league_losers.map{|m| m.rating}], [1,2])
    league_graph.update_skills

    league_winners.first.update_rating(league_graph.teams.first.first)
    league_winners.last.update_rating(league_graph.teams.first.last)
    league_losers.first.update_rating(league_graph.teams.last.first)
    league_losers.last.update_rating(league_graph.teams.last.last)

    GameLogEnd.create(:game=>self, :team=>winner)

    save
  end

  def loser
    if away_win?
      home
    elsif home_win?
      away
    else
      nil
    end
  end

  def winner
    if home_win?
      home
    elsif away_win?
      away
    else
      nil
    end
  end

  def tie?
    home_score == away_score
  end

  def home_win?
    home_score > away_score
  end

  def away_win?
    away_score > home_score
  end

  private
    def complete_if_has_scores
      self.complete! if home_score.to_i != 0 or away_score.to_i != 0
    end

    def create_game_start_log
      GameLogStart.create(:game=>self, :team=>home)
    end

    def create_teams
      errors.add(:teams, 'You think your going to need any players on those teams?') and return if home_team_players.empty? || away_team_players.empty?
      self.home = league.teams.find_or_create_by_players(home_team_players)
      self.away = league.teams.find_or_create_by_players(away_team_players)
    end

end
