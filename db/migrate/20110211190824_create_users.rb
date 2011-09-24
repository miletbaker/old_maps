class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
			t.string      :email,               :null => false                # optional, you can use login instead, or both
			t.string      :crypted_password,    :null => false                # optional, see below
			t.string      :password_salt,       :null => false                # optional, but highly recommended
			t.string      :persistence_token,   :null => false                # required
			t.string 		  :perishable_token, 		:default => "", :null => false
			t.datetime    :last_login_at	                                    # optional, see Authlogic::Session::MagicColumns
			t.string		  :name
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
