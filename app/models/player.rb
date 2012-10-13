class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, #:validatable,
         :omniauthable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :twitter_name

  has_many :league_memberships, :inverse_of => :player
  has_many :leagues, :through => :league_memberships, :inverse_of => :players

  has_many :team_memberships, :inverse_of => :player
  has_many :teams, :through => :team_memberships, :inverse_of => :players

  before_validation :set_temporary_email, :if => Proc.new { |p| p.email.blank? }

  validates :email, :presence => true, :uniqueness => true
  validates :twitter_name, :uniqueness => true

  def avatar
    Dragonfly[:images].fetch_url("https://api.twitter.com/1/users/profile_image/#{twitter_name}?size=bigger")
  end

  def avatar_url
    twitter_name.present? ? "https://api.twitter.com/1/users/profile_image/#{twitter_name}?size=bigger" : '/assets/default-player-logo.png'
  end

  def to_s
    return "#{name} (#{twitter_name})" if name != twitter_name
    return twitter_name
  end

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |player|
      player.provider = auth.provider
      player.uid = auth.uid
      player.twitter_name = auth.info.nickname
      player.name = auth.info.nickname
      player.email = "twitter-#{auth.uid}@foosleague.com"
    end
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
