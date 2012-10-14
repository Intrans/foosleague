module PlayersHelper
  def streak(player, league)
    return "" if player.games.where(:league_id => league.id).empty?
    last_games = player.games.where(:league_id => league.id).order('created_at desc')
    last_game = last_games.shift
    last_result = player.game_result?(last_game)
    streak = 1

    last_games.each do |game|
      if player.game_result?(game) == last_result
        streak += 1
      else
        break
      end
    end
    return "#{streak} #{last_result.upcase}"
  end
end
