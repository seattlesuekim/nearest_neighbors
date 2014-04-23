class CreateSigs < ActiveRecord::Migration
  def change
    create_table :sig, id: false do |t|
    	t.string :signer, null: false
	t.string :signed, null: false
    end
  end
end
