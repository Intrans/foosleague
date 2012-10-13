class LeagueMembership < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :league
  belongs_to :player
end
