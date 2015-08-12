require_relative '../config/environment'

require 'pry'
class Get_Player_Data
  
  BASE_URL ||= "http://www.fantasyfootballnerd.com/service/players/json/" 

  @@rankings = { "Aaron Rodgers" => 1, "Andrew Luck" => 2, "Russell Wilson" => 3, "Peyton Manning" => 4, 
              "Drew Brees" => 5, "Ben Roethlisberger" => 6, "Matt Ryan" => 7, "Cam Newton " => 8, "Tony Romo" => 9, 
              "Tom Brady" => 10,
              "Antonio Brown" => 1, "Demaryius Thomas" => 2, "Dez Bryant" => 3, "Odell Beckham Jr." => 4, "Jordy Nelson" => 5,
              "Julio Jones" => 6, "Calvin Johnson" => 7, "A.J. Green" => 8, "Alshon Jeffery" => 9, "Randall Cobb" => 10,
              "Le'Veon Bell" => 1, "Eddie Lacy" => 2, "Jamaal Charles" => 3, "Adrian Peterson" => 4, "Marshawn Lynch" => 5,
              "C.J. Anderson" => 6, "Matt Forte" => 7, "DeMarco Murray" => 8, "LeSean McCoy" => 9, "Jeremy Hill" => 10,
              "Rob Gronkowski" => 1, "Jimmy Graham" => 2, "Greg Olsen" => 3, "Travis Kelce" => 4, "Martellus Bennett" => 5,
              "Julius Thomas" => 6, "Jason Witten" => 7, "Zack Ertz" => 8, "Dwayne Allen" => 9, "Jordan Cameron" => 10,
              "Stephen Gotskowski" => 1, "Adam Vinatieri" => 2, "Steven Hauschka" => 3, "Connor Barth" => 4, "Justin Tucker" => 5,
              "Cody Parkey" => 6, "Matt Prater" => 7, "Matt Bryant" => 8, "Dan Bailey" => 9, "Dan Carpenter" => 10,   


            }



  def initialize(position)
    @position = position
  end

  def get_players_by_position
    @json_data = RestClient.get(BASE_URL+KEY+@position)
  end

  def parse_players_by_position
    @parsed_data = JSON.parse(@json_data)["Players"]
  end

  def add_vote_key
    @parsed_data.map do |player_hash|
      player_hash["votes"] = 0
    end
    @parsed_data
  end

  def remove_inactive_players
    @parsed_data.delete_if do |player_hash|
      player_hash["active"] == "0"
    end
  end

  def assign_rankings
    @parsed_data.map do |player_hash|
      if @@rankings.keys.include?(player_hash["displayName"])
        player_hash["ranking"] = @@rankings[player_hash["displayName"]] 
      end
    end
    @parsed_data

  end

  def limit_to_ranked
     @parsed_data.select! do |player_hash|
      player_hash.keys.include?("ranking")
    end

  end

  def run
    get_players_by_position
    parse_players_by_position
    add_vote_key
    remove_inactive_players
    assign_rankings
    limit_to_ranked
  end



end

# test = Get_Player_Data.new("K")
# test.run

# qb = Get_Player_Data.new("QB")
# puts qb.run.class

# To-do if have time

# User - give them height/weight/college/stats









