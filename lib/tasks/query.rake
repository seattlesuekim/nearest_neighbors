require 'sks_parser'
namespace 'query' do
  desc 'Checks Wikipedia for famous people in WoT'
  task 'vip' do |t|
  Neighbor.query_wikipedia
  end

  desc 'Generates YAML from keydump'
  task 'keydump' do |t|
    dump_yml = SksParser.parse_dump('/Users/sue/IdeaProjects/sks/')
    File.new('/lib/assets/dump_hash.yml', 'w+') {|f| YAML.dump(dump_yml, f) }
  end
end
