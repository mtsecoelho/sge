#rails g migration RemovePasswordFromUsers password:string
class RemovePasswordFromUsers < ActiveRecord::Migration[6.0]
  def change

    remove_column :users, :password, :string
  end
end
