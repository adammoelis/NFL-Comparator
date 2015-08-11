require_relative '../config/environment'

class User




end

class Ranking_CLI

  VALID_COMMANDS =["qb", "rb", "wr", "te", "k"]

  def run
    initial_menu
    menu
    get_user_input
    while invalid_input?
      menu
      get_user_input
    end
    player_generator(@user_input)
    display_player_names
  end

  def initial_menu
    puts "Welcome to a Crowd-Sourced Fantasy Football Ranking System"
    # user input for position, return position array
  end

  def menu
    puts "What position would you like to choose (QB, RB, WR, TE, K)?"

  end


  def player_generator(position)
    @position_array = Get_Player_Data.new(position).run
    @random_player_array = @position_array.sample(2)
    @player1_hash = @random_player_array[0]
    @player2_hash = @random_player_array[1]
    
  end

  def display_player_names
    puts "#{@player1_hash["displayName"]} vs. #{@player2_hash["displayName"]}"

  end
  

  def get_user_input
    @user_input = gets.chomp.downcase
  end

  def invalid_input?
    puts "Invalid input." if !VALID_COMMANDS.include?(@user_input)
    !VALID_COMMANDS.include?(@user_input)
  end







end

test = Ranking_CLI.new
test.run


  