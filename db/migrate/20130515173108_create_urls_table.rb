class CreateUrlsTable < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.string :short_url
      t.references :user, :null => true
    end
  end
end
