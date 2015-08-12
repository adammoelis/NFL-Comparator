require_relative '../config/environment'


class Get_Player_Data
  
  BASE_URL = "http://www.fantasyfootballnerd.com/service/players/json/" 

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

  def run
    get_players_by_position
    parse_players_by_position
    add_vote_key
  end



end

# qb = Get_Player_Data.new("QB")
# puts qb.run.class

# To-do if have time

# Player weighting/rank 
# User - give them height/weight/college/stats









