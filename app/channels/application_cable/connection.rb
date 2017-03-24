module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	identified_by :current_user

  	def connect
  		self.current_user = find_verified_user
  	end

  	def disconnect

  	end

  	protected 
  	def find_verified_user
  		if verfied_user = request.env['warden'].user
  			verfied_user
  		else
  			reject_unauthorized_connection
  		end
  	end
  end
end
