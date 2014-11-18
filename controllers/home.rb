module VirtualBrain
  module Controllers
    module Home
      include VirtualBrain::Controller

      action 'Index' do 
        expose :name

        def call(params)
          @name = params[:name]
        end
      end
    end
  end
end
