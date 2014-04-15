require 'sks_parser'
class Neighbor

  DUMP_HASH = SksParser.parse_dump('app/dump')

  #recurse through dump_hash to find the n nearest neighbors
  def self.nearest_neighbors(keyid, n)
    n = n.to_i
    neighbors = []
    #base case
    if n == 0
      return neighbors
    #base case
    elsif n == 1
      neighbors << DUMP_HASH[keyid][:sigs]
    else
      for sig in DUMP_HASH[keyid][:sigs]
        n -= 1
        self.nearest_neighbors(sig, (n))
      end
    end
  end
end
