require 'yaml'
require 'net/http'

class Neighbor

  #recurse through dump_hash to find the n nearest neighbors
  def self.nearest_neighbors(keyid, n=1)
    keyid = keyid.upcase
    n = n.to_i
    uid = Uid.find_by(id: keyid)
    return [] unless uid
    #base case
    if n == 1
      uid.signed_by
    else
      neighbors = []
      for sig in uid.signed_by
        neighbors.concat(self.nearest_neighbors(sig, (n-1)))
      end
      neighbors
    end
  end

  def self.to_name(keyid)
    uid = Uid.find_by(id: keyid)
    if uid && uid.name
      uid.name
    else
      "unknown"
    end
  end

  #this won't work for more than one person with the same name,
  # or someone with the same name as a vip.
  def self.query_wikipedia
    File.open('lib/assets/vip.dat', 'w') do |f|
      DUMP_HASH.each do |keyid, sub_hash|
        if sub_hash[:user]
          name = sub_hash[:user].split(' <')[0].split(' (')[0]
          if name.nil? == false
            name = name.tr!(' ', '_')
            STDERR.puts '.'
          end
        end
        begin
          uri =  URI("http://en.wikipedia.org/wiki/#{name}")
          response = Net::HTTP.get_response(uri)
          if response.code == '200'
            f.write("#{keyid}\n")
            STDERR.puts "#{name}"
          end
        rescue URI::InvalidURIError => e
        end
      end
    end
  end


end




