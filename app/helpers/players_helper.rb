module PlayersHelper
  def streak(player, league)
    return "" if player.games.empty?
    last_games = player.games.order('created_at desc')
    last_game = last_games.shift
    # last_result = game_result?(last_game)
    last_result = "W"
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
