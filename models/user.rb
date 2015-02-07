module VirtualBrain
	module Models
		class User
			include Lotus::Entity
			#jeder User hat diese Eigenschaften:
			self.attributes = :email, :password
		end
	end
end