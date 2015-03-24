module VirtualBrain
	module Repositories
		class TaskRepository
			include Lotus::Repository

			#Aufgaben für einen best. Benutzer laden
			def self.for_user(user_id)
				query do
					where(user_id: user_id)
				end
			end

			def self.latest_tasks(user_id)
				query do
					where(user_id: user_id).desc(:id)
				end
			end

			def self.alphabetically(user_id)
				query do
					where(user_id: user_id).asc(:name)
				end
			end
		end
	end
end


