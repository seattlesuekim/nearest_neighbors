class CreateVips < ActiveRecord::Migration
  def change
    create_table :vips, id: false do |t|
      t.string :id, null: false
    end
  end
end
