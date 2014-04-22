require 'yaml'
require 'net/http'

class Neighbor

  DUMP_HASH ||= YAML.load_file('lib/assets/dump_hash.yml')

  #recurse through dump_hash to find the n nearest neighbors
  def self.nearest_neighbors(keyid, n)
    keyid = keyid.upcase
    n = n.to_i
    neighbors = []
    #base case
    if n == 0
      return neighbors
    #base case
    elsif n == 1
      if DUMP_HASH[keyid]
        neighbors << DUMP_HASH[keyid][:sigs]
      else
        raise('not in dir')
      end
    else
      for sig in DUMP_HASH[keyid][:sigs]
        n -= 1
        self.nearest_neighbors(sig, (n))
      end
    end
  end

  def self.to_name(keyid)
    if DUMP_HASH[keyid] && DUMP_HASH[keyid][:user].split(' <')[0]
      DUMP_HASH[keyid][:user].split(' <')[0].tr!(' ', '_')
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




