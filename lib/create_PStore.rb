
class Create_PStore_Vote_Hash
  
  def qb_hash
    @@qb_vote_hash ||= PStore.new('qb.txt')
      @@qb_vote_hash.transaction do 
        if @@qb_vote_hash.roots.empty?
            Get_Player_Data.new("QB").run.each do |player_hash|
                @@qb_vote_hash[player_hash["displayName"]] = player_hash["votes"]
            end
            @@qb_vote_hash.commit
        end
      end
    @@qb_vote_hash
  end

  def wr_hash
    @@wr_vote_hash ||= PStore.new('wr.txt')
    @@wr_vote_hash.transaction do 
        Get_Player_Data.new("WR").run.each do |player_hash|
            @@wr_vote_hash[player_hash["displayName"]] = player_hash["votes"]
        end
        @@wr_vote_hash.commit
    end
  end

  def rb_hash
    @@rb_vote_hash ||= PStore.new('rb.txt')
    @@rb_vote_hash.transaction do 
        Get_Player_Data.new("RB").run.each do |player_hash|
            @@rb_vote_hash[player_hash["displayName"]] = player_hash["votes"]
        end
        @@rb_vote_hash.commit
    end
  end

  def te_hash
    @@te_vote_hash ||= PStore.new('te.txt')
    @@te_vote_hash.transaction do 
      Get_Player_Data.new("TE").run.each do |player_hash|
          @@te_vote_hash[player_hash["displayName"]] = player_hash["votes"]
      end
      @@te_vote_hash.commit
    end

  end

  def k_hash
    @@k_vote_hash ||= PStore.new('k.txt')
    @@k_vote_hash.transaction do 
        Get_Player_Data.new("K").run.each do |player_hash|
            @@k_vote_hash[player_hash["displayName"]] = player_hash["votes"]
        end
        @@k_vote_hash.commit
    end
  end
  

end