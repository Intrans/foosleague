["Freedom Freight", "Mitre Media", "Lift Interactive"].each do |league|
  League.create! :name => league
end

Player.create! :twitter_name => "sea", :name => "Sean McCann"
Player.create! :twitter_name => "mdeering", :name => "Michael Deering"
Player.create! :twitter_name => "agyuricska", :name => "Adrian Gyuricska"
Player.create! :twitter_name => "nickvisual", :name => "Andrew Nickerson"

League.all.each do |league|
  Player.all.each do |player|
    league.league_memberships.create do |league_membership|
      league_membership.player = player
    end
  end
end
