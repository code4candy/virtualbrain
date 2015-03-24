module VirtualBrain
	module Models
		class Task
			include Lotus::Entity
			self.attributes = :name, :user_id


			def delete
				
			end
		end
	end
end