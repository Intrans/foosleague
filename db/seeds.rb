["FoosLeague", "Freedom Freight", "Mitre Media", "Lift Interactive"].each do |league|
  League.create!(:name => league)
end

Player.create!(:twitter_name => "sea", :name => "S. McCann")
Player.create!(:twitter_name => "mdeering", :name => "M. Deering")
Player.create!(:twitter_name => "agyuricska", :name => "A. Gyuricska")
Player.create!(:twitter_name => "timfletcher", :name => "T. Fletcher")
Player.create!(:twitter_name => "brandonwebber", :name => "B. Webber")
Player.create!(:twitter_name => "thorrenkoopmans", :name => "T. Koopmans")
Player.create!(:twitter_name => "scottbrooksca", :name => "S. Brooks")
Player.create!(:twitter_name => "eminem", :name => "M. Mathers")
Player.create!(:twitter_name => "elidupuis", :name => "E. Dupuis")
Player.create!(:twitter_name => "chrisrockoz", :name => "C. Rock")
Player.create!(:twitter_name => "TimSloan", :name => "T. Sloan")

League.all.each do |league|
  Player.all.each do |player|
    league.players << player
  end
end

puts "Seeding Games"
foosleague_league = League.first
300.times do
  all_players = foosleague_league.players.dup.shuffle
  winner_score = rand(3) + 10
  foosleague_league.games.create!(:home_score => winner_score, :away_score => winner_score-2, :home_team_players => all_players.pop(2), :away_team_players => all_players.pop(2))
  foosleague_league.games.create!(:home_score => winner_score-2, :away_score => winner_score, :home_team_players => all_players.pop(2), :away_team_players => all_players.pop(2))
end

mitre_league = League.first
200.times do
  all_players = mitre_league.players.dup.shuffle
  winner_score = rand(3) + 10
  mitre_league.games.create!(:home_score => winner_score, :away_score => winner_score-2, :home_team_players => all_players.pop(2), :away_team_players => all_players.pop(2))
  mitre_league.games.create!(:home_score => winner_score-2, :away_score => winner_score, :home_team_players => all_players.pop(2), :away_team_players => all_players.pop(2))
end

Game.all.each do |game|
  set_day = rand(250).days.ago
  game.created_at = set_day
  game.save!
end
