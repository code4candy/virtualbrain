module VirtualBrain
  module Controllers
    module Users
      include VirtualBrain::Controller

      action 'New' do
      	def call(params)	
      	end
      end

      #legt den User an in der Datenbank
      action 'Create' do 

      	#params = was server vom webbrowser bekommt
      	def call(params)
      		#legt neues User-Objekt an
        	new_user = VirtualBrain::Models::User.new({email: params[:email], 
        		password: params[:password]})
        	#User-Objekt in Datenbank speichern
        	VirtualBrain::Repositories::UserRepository.create(new_user)
        	redirect_to '/' #danach wieder auf home-seite gehen
    	  end
      end

      action 'Showsignin' do #zeigt signin-Seite an
        def call(params)
        end
      end

    end
  end
end