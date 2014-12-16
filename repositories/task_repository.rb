module VirtualBrain
	module Repositories
		class TaskRepository
			include Lotus::Repository

			def self.latest_tasks
				query do
					desc(:id)
				end
			end

			def self.alphabetically
				query do
					asc(:name)
				end
			end
		end
	end
end


