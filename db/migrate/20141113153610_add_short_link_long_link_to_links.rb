class AddShortLinkLongLinkToLinks < ActiveRecord::Migration
  def change
    add_column :links, :long_link, :string
    add_column :links, :short_link, :string
  end
end
