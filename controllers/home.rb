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
          user_id = session[:user]  #
          puts "SESSION: #{:user}"
          if params[:newest]
            @tasks = VirtualBrain::Repositories::TaskRepository.latest_tasks(user_id)
          elsif params[:alphabetically]
            @tasks = VirtualBrain::Repositories::TaskRepository.alphabetically(user_id)
          else
            @tasks = VirtualBrain::Repositories::TaskRepository.for_user(user_id)
          end
          @user = VirtualBrain::Repositories::UserRepository.by_id(session[:user])
        end
      end

      action 'Create' do
        include Lotus::Action::Session
        def call(params)
          new_task = VirtualBrain::Models::Task.new({
            name: params[:task], 
            user_id: session[:user]}) 
          #parameter hier ist hash von home/index
          if !new_task.name.nil? && !new_task.name.strip.empty? # strip->löscht Leerzeichen am Anfang und am Ende eines Strings
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
