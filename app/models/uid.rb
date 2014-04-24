class Uid < ActiveRecord::Base
  self.primary_key = 'id'

  def signed
    Uid.connection.select_all("select * from sigs where signer = '#{self.id}'").map{|h| h['signed']}
  end

  def signed_by
    Uid.connection.select_all("select * from sigs where signed = '#{self.id}'").map{|h| h['signer']}
  end
end
