class League < ActiveRecord::Base
  attr_accessible :name

  has_many :league_memberships, :inverse_of => :league
  has_many :players, :through => :league_memberships, :inverse_of => :leageus

end
