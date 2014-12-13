class CreateUrls < ActiveRecord::Migration
def change
	drop_table :urls
	
    create_table :urls do |t|
      t.string :location
      t.string :base64

      t.timestamps
    end
  end
end
