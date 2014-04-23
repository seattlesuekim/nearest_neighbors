class CreateUids < ActiveRecord::Migration
  def change
    create_table :uids, id: false do |t|
    	t.string :id, null: false
	t.string :name, null: false
	t.string :email, null: false
    end
  end
end
