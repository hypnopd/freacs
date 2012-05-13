module AuctionsHelper
  def count_rank(user,auction)
    if user.offers.empty?
      "-"
    else
      return "1."
    end
  end
end
