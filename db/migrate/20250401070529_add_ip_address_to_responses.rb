class AddIpAddressToResponses < ActiveRecord::Migration[7.1]
  def change
    add_column :responses, :ip_address, :string
  end
end
