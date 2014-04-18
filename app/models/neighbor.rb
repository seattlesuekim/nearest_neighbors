require 'wikipedia'
require 'yaml'

class Neighbor

  DUMP_HASH = YAML.load_file('/lib/assets/dump_hash.yml')

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
    DUMP_HASH[keyid][:user].split(' <')[0]
  end


  def self.wikipedia_page(name)
    Wikipedia.find(name)
  end

  #this won't work for more than one person with the same name,
  # or someone with the same name as a vip.
  def self.query_wikipedia
    vip_hash = {}
    DUMP_HASH.each do |keyid|
      name = keyid[:user.split(' <')[0]].tr!(' ', '_')
      response = http.head("/wiki/#{name}")
      if response.code != '404'
        vip_hash[name] = response
      end
      File.open('/lib/assets/vip.yml', 'w') {|f| YAML.dump(vip_hash, f) }
    end
  end

  def self.find_vip(name)
    vip_hash = YAML.load_file('lib/assets/vip.yml')
    if vip_hash.include?(name)
      vip_hash[name]
    end
  end

end




