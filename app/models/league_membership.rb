class LeagueMembership < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :league, :inverse_of => :league_memberships
  belongs_to :player, :inverse_of => :league_memberships
end
