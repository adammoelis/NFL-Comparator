class Read_Write_PStore_Vote_Hash


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


end