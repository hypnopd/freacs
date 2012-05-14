module AuctionsHelper
  def compute_rank(user,auction)
    if user.offers.empty?
      "-"
    else
      users_sums = {}
      users_sums[user.id] = auction.compute_sum(user)
      @auction_users.each do |auser|
        unless auser.offers.empty?
          users_sums[auser.user_id] = auction.compute_sum(auser.user)
        end
      end
      ordered= Hash[users_sums.sort{|k,v| k[1] <=> v[1]}]
      ordered.find_index {|k,v| k == user.id} +1
    end
  end
end
