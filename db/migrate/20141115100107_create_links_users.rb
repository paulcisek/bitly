class CreateLinksUsers < ActiveRecord::Migration
  def change
    create_table :links_users, id:false  do |t|
      t.belongs_to :user
      t.belongs_to :link
    end
  end
end
