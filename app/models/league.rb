class League < ActiveRecord::Base
  attr_accessible :name

  has_many :league_memberships
  has_many :players, :through => :league_memberships

end
