class User < ActiveRecord::Base
		
		# 		t.string   "email",                                :null => false
		#     t.string   "crypted_password",                     :null => false
		#     t.string   "password_salt",                        :null => false
		#     t.string   "persistence_token",                    :null => false
		#     t.string 	 :perishable_token, 		:default => "",  :null => false
		#     t.datetime "last_login_at"
		#     t.string   "name"
		#     t.datetime "created_at"
		#     t.datetime "updated_at"
		
		
		#Named scopes
		scope :search, lambda { |*args| { 
			:conditions => [
				"email like :search or name like :search",
				{:search => "%#{args.first}%"}
			]
		}}
		
		# Behaviour
		acts_as_authentic

		# Validation
		validates_presence_of :name

		# Instance methods / properties

		def reset_password!  
			reset_perishable_token!  
			Notification.deliver_reset_password(self)  
		end
		
		def logged_in_url
			# Modify to logged in welcome page, add role logic here
			"/logged_in"
		end
end