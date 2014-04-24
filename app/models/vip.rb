class Vip < ActiveRecord::Base
  self.primary_key = 'id'

  def url
    uid = Uid.find(id)
    "http://en.wikipedia.org/wiki/#{uid.name.gsub(' ', '_')}"
  end
end
