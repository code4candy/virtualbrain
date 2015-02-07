require 'lotus/action/session' # für Zeile 9 & 16/17

module VirtualBrain
  module Controllers
    module Sessions
      include VirtualBrain::Controller

      action 'Create' do 
        include Lotus::Action::Session
        #params = was server vom webbrowser bekommt
        def call(params)
          user = VirtualBrain::Repositories::UserRepository.get_user(params[:email] , params[:password])
          if user.nil?  #wenn eingabe nicht valid
            redirect_to 'users/signin' #dann wieder auf home-seite gehen
          else
            session[:user] = user.id  #
            redirect_to '/'
          end
        end
      end

      

    end
  end
end