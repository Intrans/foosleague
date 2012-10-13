["Freedom Freight", "Mitre Media", "Lift Interactive"].each do |league|
  League.create!(:name => league)
end

Player.create!(:twitter_name => "sea", :name => "Sean McCann")
Player.create!(:twitter_name => "mdeering", :name => "Michael Deering")
Player.create!(:twitter_name => "agyuricska", :name => "Adrian Gyuricska")

League.all.each do |league|
  Player.all.each do |player|
    league.players << player
  end
end
