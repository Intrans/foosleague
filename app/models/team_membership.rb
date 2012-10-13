class TeamMembership < ActiveRecord::Base

  belongs_to :team, :counter_cache => :player_count
  belongs_to :player

  validates_presence_of :team, :player

  validates_uniqueness_of :player_id, :scope => :team_id
end
