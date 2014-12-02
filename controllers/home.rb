module VirtualBrain
  module Controllers
    module Home
      include VirtualBrain::Controller

      action 'Index' do 
        expose :task

        def call(params)
          @task = params[:task]
        end
      end
    end
  end
end
