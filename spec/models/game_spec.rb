require 'spec_helper'

describe Game do
  before :each do
    @players = []
    4.times do |n|
      @players << create(:player, :name => "Player #{n}")
    end
    
    @league = create(:league)
    @league.players << @players
    @home = @players.pop(2)
    @away = @players
    @game = @league.games.create! :home_team_players => @home,
                               :away_team_players => @away,
                               :home_score => 10,
                               :away_score => 8
    
  end
  
  describe "removal of games" do
    it "should revert the true_skill score" do
      original_home_team_true_skill = @game.home.skill
      original_away_team_true_skill = @game.away.skill
      original_player_1_true_skill = @league.league_memberships.find_by_player_id(@home[0].id).skill
      original_player_2_true_skill = @league.league_memberships.find_by_player_id(@home[1].id).skill
      original_player_3_true_skill = @league.league_memberships.find_by_player_id(@away[0].id).skill
      original_player_4_true_skill = @league.league_memberships.find_by_player_id(@away[1].id).skill
      
      @game_2 = @league.games.create! :home_team_players => @home, :away_team_players => @away, 
        :home_score => 10, :away_score => 8
      
      @game_3 = @league.games.create! :home_team_players => @home, :away_team_players => @away, 
        :home_score => 10, :away_score => 8
      
      # At this point, the away player should have a very low score, < 21.44140159027513
      
      @game_3.destroy
      
      # At this point, the away player should have a score of about 21.44140159027513
      @league.league_memberships.find_by_player_id(@away[0].id).reload.skill.should_not == original_player_3_true_skill
      
      @game_2.destroy
      @league.league_memberships.find_by_player_id(@away[0].id).reload.skill.should == original_player_3_true_skill
      @game.away.skill.should == original_away_team_true_skill
      
      # at this point, the away player should have a score of about 22.6915
      @game.destroy
      
      # at this point, the players should all have a score of 25
      (@away + @home).each do |player|
        @league.league_memberships.find_by_player_id(player.id).reload.skill.should == 25
      end
      
      @game.away.reload.skill.should == 25
      @game.home.reload.skill.should == 25
    end
  end
end