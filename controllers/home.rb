require 'lotus/action/session' #bereitgestellte Klasse von Lotus einbinden  

module VirtualBrain
  module Controllers
    module Home
      include VirtualBrain::Controller

      # crud => create-read-update-delete (Funktionen nie mischen)
      # = seperation of concerns (hier, für jede Funktion eigene ACTION erstellen )
      # = die 4 Standardmethoden eines Controllers! für das Datenmanagement
      action 'Index' do 
        include Lotus::Action::Session
        expose :tasks
        expose :user

        def call(params)
          puts "SESSION: #{session[:user]}"
          if params[:newest]
            @tasks = VirtualBrain::Repositories::TaskRepository.latest_tasks
          elsif params[:alphabetically]
            @tasks = VirtualBrain::Repositories::TaskRepository.alphabetically
          else
            @tasks = VirtualBrain::Repositories::TaskRepository.all
          end
          @user = VirtualBrain::Repositories::UserRepository.by_id(session[:user])
        end
      end

      action 'Create' do

        def call(params)
          new_task = VirtualBrain::Models::Task.new({name: params[:task]}) 
          #parameter hier ist hash von home/index
          if !new_task.name.nil? && !new_task.name.strip.empty? 
            # legt in Datenbank neue Zeile an und speichert dort den Task
            VirtualBrain::Repositories::TaskRepository.create(new_task)
          end     
          redirect_to '/' # Lotus Methode

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
