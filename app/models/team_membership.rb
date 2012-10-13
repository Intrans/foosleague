class TeamMembership < ActiveRecord::Base

  belongs_to :team, :inverse_of => :memberships
  belongs_to :player, :inverse_of => :team_memberships

  validates_presence_of :team, :player

  validates_uniqueness_of :player_id, :scope => :team_id
end
