class GameLog < ActiveRecord::Base
  attr_accessor :event
  attr_accessible :game_id, :team_id

  belongs_to :game
  belongs_to :team

  validates_presence_of :game, :team

  scope :score, where(:type => 'GameLogScore')
  scope :game_start, where(:type => 'GameLogStart')
  scope :game_end, where(:type => 'GameLogEnd')
end