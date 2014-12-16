module VirtualBrain
  module Controllers
    module Home
      include VirtualBrain::Controller

      action 'Index' do 
        expose :tasks

        def call(params)
          new_task = VirtualBrain::Models::Task.new({name: params[:task]}) 
          #parameter hier ist hash von home/index
          if !new_task.name.nil? && !new_task.name.strip.empty? 
            # legt in Datenbank neue Zeile an und speichert dort den Task
            VirtualBrain::Repositories::TaskRepository.create(new_task)
          end          
          @tasks = VirtualBrain::Repositories::TaskRepository.all
        end
      end

      action 'Delete' do

        def call(params)
          task = VirtualBrain::Repositories::TaskRepository.find(params[:task_id])
          VirtualBrain::Repositories::TaskRepository.delete(task)
          redirect_to '/' # Lotus Methode
        end
      end
    end
  end
end
