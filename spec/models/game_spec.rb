require 'spec_helper'

describe Game do
  before :each do
    @players = []
    4.times do |n|
      @players << create(:player, :name => "Player #{n}")
    end
    
    league = create(:league)
    @game = league.games.create! :home_team_players => @players.pop(2),
                               :away_team_players => @players,
                               :home_score => 10,
                               :away_score => 8
                               
  end
  
  describe "removal of games" do
    it "have the correct game state" do
      
    end
    
    it "should revert the true_skill score" do
      debugger
      original_team_true_skill = @game.home.true_skill
      original_player_1_true_skill = @game.home.player
    end
  end
end