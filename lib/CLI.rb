
class Ranking_CLI

  attr_reader :player1_hash, :player2_hash, :vote_hash

  VALID_COMMANDS ||= ["qb", "rb", "wr", "te", "k", "exit"]
  SELECT_PLAYER_VALID_COMMANDS ||= ["1","2"]

  def initialize
    @@qb_vote_hash ||= Create_PStore_Vote_Hash.new.qb_hash
    @@wr_vote_hash ||= Create_PStore_Vote_Hash.new.wr_hash
    @@rb_vote_hash ||= Create_PStore_Vote_Hash.new.rb_hash
    @@te_vote_hash ||= Create_PStore_Vote_Hash.new.te_hash
    @@k_vote_hash ||= Create_PStore_Vote_Hash.new.k_hash
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
      while invalid_player_selection?
        select_player
      end 
      case @user_input
        when "qb" then update_qb_hash 
        when "rb" then update_rb_hash 
        when "wr" then update_wr_hash 
        when "te" then update_te_hash 
        when "k" then update_k_hash 
      end
      # binding.pry
    end
  end

  def self.reset_qb
    @@qb_vote_hash.set_values_to_zero
  end
  
  def self.reset_wr
    @@wr_vote_hash.set_values_to_zero
  end
  
  def self.reset_rb
    @@rb_vote_hash.set_values_to_zero
  end
  
  def self.reset_te
    @@te_vote_hash.set_values_to_zero
  end
  
  def self.reset_k
    @@k_vote_hash.set_values_to_zero
  end

  def self.reset_all
    self.reset_qb
    self.reset_wr
    self.reset_rb
    self.reset_te
    self.reset_k
  end

  def convert_pstore_to_hash(pstore_object)
    pstore_object.transaction(true) do
      @player_hash = {}
      pstore_object.roots.each do |player_name|
        @player_hash[player_name] = pstore_object[player_name]
      end
    end
    @player_hash
  end

  def sort_converted_pstore_hash_to_rankings(player_hash, num_rankings)
    @top_player_votes_array = player_hash.sort_by {|player_name, votes| votes}.reverse.first(num_rankings)
    @top_player_votes_array.each.with_index(1) do |array, index|
      puts "#{index}. #{array[0]} - #{array[1]}"
    end
  end


  def self.qb_vote_hash
    @@qb_vote_hash.transaction(true) do
      @@qb_vote_hash.roots.each do |player_name|
        puts "#{player_name} #{@@qb_vote_hash[player_name]}"
      end
    end
  end

  def self.wr_vote_hash
     @@wr_vote_hash.transaction(true) do
      @@wr_vote_hash.roots.each do |player_name|
        puts "#{player_name} #{@@wr_vote_hash[player_name]}"
      end
    end
  end

  def self.rb_vote_hash
     @@rb_vote_hash.transaction(true) do
      @@rb_vote_hash.roots.each do |player_name|
        puts "#{player_name} #{@@rb_vote_hash[player_name]}"
      end
    end
  end

   def self.te_vote_hash
     @@te_vote_hash.transaction(true) do
      @@te_vote_hash.roots.each do |player_name|
        puts "#{player_name} #{@@te_vote_hash[player_name]}"
      end
    end
  end

   def self.k_vote_hash
     @@k_vote_hash.transaction(true) do
      @@k_vote_hash.roots.each do |player_name|
        puts "#{player_name} #{@@k_vote_hash[player_name]}"
      end
    end
  end




  def initial_menu
    puts "Welcome to a Crowd-Sourced Fantasy Football Ranking System"
    
  end

  def menu
    puts "========================================================================="
    puts "What position would you like to choose (QB, RB, WR, TE, K, exit to quit)?"
    puts "========================================================================="

  end


  def player_generator(position)
    @position = position
    @position_array = Get_Player_Data.new(position).run
    @random_player_array = @position_array.sample(2)
    @player1_hash = @random_player_array[0]
    @player2_hash = @random_player_array[1]
    
  end

  def display_player_names
    puts "========================================================================="
    puts "1.#{@player1_hash["displayName"]}\nvs.\n2.#{@player2_hash["displayName"]}"
    puts "========================================================================="
    puts "Choose 1 to select #{@player1_hash["displayName"]} or 2 to select #{@player2_hash["displayName"]}"
    puts "================================================================================================="
  end
  

  def get_user_input
    @user_input = gets.chomp.downcase
    @user_input == "exit" ? exit : @user_input
  end

  def exit
    puts "================================================================================"
    puts "Top 5 Quarterbacks"
    sort_converted_pstore_hash_to_rankings(convert_pstore_to_hash(@@qb_vote_hash),5)
    puts "================================================================================"
    puts "Top 5 Wide Receivers"
    sort_converted_pstore_hash_to_rankings(convert_pstore_to_hash(@@wr_vote_hash),5)
    puts "================================================================================"
    puts "Top 5 Running Backs"
    sort_converted_pstore_hash_to_rankings(convert_pstore_to_hash(@@rb_vote_hash),5)
    puts "================================================================================"
    puts "Top 5 Tight Ends"
    sort_converted_pstore_hash_to_rankings(convert_pstore_to_hash(@@te_vote_hash),5)
    puts "================================================================================"
    puts "Top 5 Kickers"
    sort_converted_pstore_hash_to_rankings(convert_pstore_to_hash(@@k_vote_hash),5)
    puts "================================================================================"
    abort
  end

  def invalid_input?
    puts "Invalid input." if !VALID_COMMANDS.include?(@user_input)
    !VALID_COMMANDS.include?(@user_input)
  end

  def invalid_player_selection?
    puts "==================================="
    puts "Invalid input. Please select 1 or 2" if !SELECT_PLAYER_VALID_COMMANDS.include?(@player_selection)
    !SELECT_PLAYER_VALID_COMMANDS.include?(@player_selection)
  end

  def select_player
    @player_selection = gets.chomp.downcase 
    exit if @player_selection == "exit"
    @player_selection
  end

  def update_qb_hash
    @@qb_vote_hash.transaction do 
      @@qb_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
      @@qb_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
      @@qb_vote_hash.commit
    end
  end

  def update_wr_hash
    @@wr_vote_hash.transaction do 
      @@wr_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
      @@wr_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
      @@wr_vote_hash.commit
    end
  end

  def update_rb_hash
    @@rb_vote_hash.transaction do 
      @@rb_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
      @@rb_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
      @@rb_vote_hash.commit
    end
  end

   def update_te_hash
    @@te_vote_hash.transaction do 
      @@te_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
      @@te_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
      @@te_vote_hash.commit
    end
  end

  def update_k_hash
    @@k_vote_hash.transaction do 
      @@k_vote_hash[@player1_hash["displayName"]] += 1 if @player_selection == "1"
      @@k_vote_hash[@player2_hash["displayName"]] += 1 if @player_selection == "2"
      @@k_vote_hash.commit
    end
  end

end

class PStore

  def set_values_to_zero
    self.transaction do
      self.roots.each do |player_name|
        self[player_name] = 0
      end
    end
  end

end



  