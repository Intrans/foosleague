class Player < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :provider, :uid, :name, :twitter_name
  
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
end
