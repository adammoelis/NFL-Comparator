
class Ranking_CLI

  attr_reader :player1_hash, :player2_hash, :vote_hash

  VALID_COMMANDS ||= ["qb", "rb", "wr", "te", "k", "exit"]

  
  @@qb_vote_hash = {}
  @@wr_vote_hash = {}
  @@rb_vote_hash = {}
  @@k_vote_hash = {}
  @@te_vote_hash = {}

  def initialize 
    Get_Player_Data.new("QB").run.each do |player_hash|
        @@qb_vote_hash[player_hash["displayName"]] = player_hash["votes"]
    end

    Get_Player_Data.new("WR").run.each do |player_hash|
        @@wr_vote_hash[player_hash["displayName"]] = player_hash["votes"]
    end

    Get_Player_Data.new("RB").run.each do |player_hash|
        @@rb_vote_hash[player_hash["displayName"]] = player_hash["votes"]
    end

    Get_Player_Data.new("K").run.each do |player_hash|
        @@k_vote_hash[player_hash["displayName"]] = player_hash["votes"]
    end

    Get_Player_Data.new("TE").run.each do |player_hash|
        @@te_vote_hash[player_hash["displayName"]] = player_hash["votes"]
    end

  end

  def self.qb_vote_hash
    @@qb_vote_hash
  end

  def self.wr_vote_hash
    @@wr_vote_hash
  end

  def self.rb_vote_hash
    @@rb_vote_hash
  end

  def self.te_vote_hash
    @@te_vote_hash
  end

  def self.k_vote_hash
    @@k_vote_hash
  end


  def run
    initial_menu
    loop do
      menu
      get_user_input
      
      while invalid_input?
        menu
        get_user_input
      end
      player_generator(@user_input)
      display_player_names
      select_player 
      case @user_input
        when "qb" then update_qb_hash 
        when "rb" then update_rb_hash 
        when "wr" then update_wr_hash 
        when "te" then update_te_hash 
        when "k" then update_k_hash 
      
      end
    binding.pry 
    end
   

  end

  def initial_menu
    puts "Welcome to a Crowd-Sourced Fantasy Football Ranking System"
  end

  def menu
    puts "What position would you like to choose (QB, RB, WR, TE, K, exit to quit)?"

  end


  def player_generator(position)
    @position = position
    @position_array = Get_Player_Data.new(position).run
    @random_player_array = @position_array.sample(2)
    @player1_hash = @random_player_array[0]
    @player2_hash = @random_player_array[1]
    
  end

  def display_player_names
    puts "1.#{@player1_hash["displayName"]}\nvs.\n2.#{@player2_hash["displayName"]}"
    puts "Choose 1 to select #{@player1_hash["displayName"]} or 2 to select #{@player2_hash["displayName"]}"

  end
  

  def get_user_input
    @user_input = gets.chomp.downcase
    abort if @user_input == "exit"
    @user_input
  end

  def invalid_input?
    puts "Invalid input." if !VALID_COMMANDS.include?(@user_input)
    !VALID_COMMANDS.include?(@user_input)
  end

  def select_player
    @player_selection = gets.chomp 
    
  end

  def update_qb_hash
    @@qb_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
    @@qb_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
  end

  def update_rb_hash
    @@rb_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
    @@rb_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
  end

  def update_wr_hash
    @@wr_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
    @@wr_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
  end

  def update_te_hash
    @@te_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
    @@te_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
  end

  def update_k_hash
    @@k_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
    @@k_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
  end


end


  