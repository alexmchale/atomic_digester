class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.references :user, index: true
      t.string :name
      t.text :url

      t.timestamps
    end
  end
end
