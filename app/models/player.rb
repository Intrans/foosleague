class Player < ActiveRecord::Base
  extend FriendlyId

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :omniauthable, :token_authenticatable

  normalize_attribute  :twitter_name, :with => :twitter

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :twitter_name

  has_many :league_memberships, :inverse_of => :player
  has_many :leagues, :through => :league_memberships, :inverse_of => :players

  has_many :team_memberships, :inverse_of => :player
  has_many :teams, :through => :team_memberships, :inverse_of => :players

  before_validation :set_temporary_email, :if => Proc.new { |p| p.email.blank? }

  validates :email, :presence => true, :uniqueness => true
  validates :twitter_name, :uniqueness => true

  # scope :by_skill, joins(:true_skill).order('skill desc')
  scope :by_skill, order('created_at')

  def <=>(other_player)
    to_s <=> other_player.to_s
  end

  def avatar
    Dragonfly[:images].fetch_url("https://api.twitter.com/1/users/profile_image/#{twitter_name}?size=bigger")
  end

  def avatar_url
    twitter_name.present? ? "https://api.twitter.com/1/users/profile_image/#{twitter_name}?size=bigger" : '/assets/default-player-logo.png'
  end

  def to_s
    return name if name.present?
    return "@#{twitter_name}" if twitter_name
  end

  def skill
    true_skill.skill
  end

  def rating
    true_skill.rating
  end

  def deviation
    true_skill.deviation
  end

  def league_membership(league)
    league_memberships.find_by_league_id(league.id)
  end

  def wins(my_team_ids = team_ids)
    Game.having_teams(my_team_ids).wins(my_team_ids)
  end

  def losses(my_team_ids = team_ids)
    Game.having_teams(my_team_ids).loses(my_team_ids)
  end

  def games(my_team_ids = team_ids)
    Game.having_teams(team_ids)
  end

  def game_result?(game)
    return "W" if teams.include? game.winner
    return "L" if teams.include? game.loser
  end

  def self.from_omniauth(auth)
    existing_player = where(auth.slice(:provider, :uid)).first
    return existing_player if existing_player

    existing_player = find_by_twitter_name(auth[:info][:nickname])
    existing_player = self.new unless existing_player

    existing_player.provider = auth.provider
    existing_player.uid = auth.uid
    existing_player.twitter_name = auth.info.nickname
    existing_player.name = auth.info.nickname unless existing_player.name.present?

    existing_player.save

    return existing_player
  end

  def self.new_with_session(params, session)
    if session["devise.player_attributes"]
      new(session["devise.player_attributes"], without_protection: true) do |player|
        player.attributes = params
        player.valid?
      end
    else
      super
    end
  end

  def password_required?
    super && provider.blank?
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def set_temporary_email
    self.email = "#{rand(9999999999999999)}@foosleague.com"
  end
end
