require 'lotus'
require 'lotus/model'

module VirtualBrain
  class Application < Lotus::Application
    configure do
      routes do
        # zeigt aus welcher Datei der Browserpfad seine Daten bekommen soll
        # Reihenfolge wichtig, da von oben nach unten durchsucht wird. erstes passendes wird genommen
        # links=angefragter Pfad im Browser, rechts=server sucht in controllers-Ordner nach Datei 
        # und in der Dateinach der entsprechenden "Action"
        get   '/',              to: 'home#index' 
        post  '/tasks/create',  to: 'home#create'
        post  '/tasks/delete',  to: 'home#delete'
        get   '/users/new',     to: 'users#new' #liefert das register-Formular aus
        post  '/users/create',  to: 'users#create'
        get   '/users/signin',  to: 'users#showsignin'
        post  '/sessions/create', to: 'sessions#create'
        post  '/sessions/delete',  to: 'sessions#delete'
        get   '/imprint',       to: 'imprint#page'

      end

      # Ordner, auf die zugegriffen werden kann
      load_paths << [
        'controllers',
        'models',
        'views',
        'repositories'
      ]
      layout :Application # Application=Default-Layout()
    end

    load! #Konfiguration abgeschlossen - startet App
  end

  # Adresse der Datenbank
  CONNECTION_URI = "sqlite://#{ __dir__ }/test.db"

  Lotus::Model.configure do
  adapter type: :sql, uri: CONNECTION_URI # Typ der Datenbank ist sql

  #mapping = Verknüpfung mit der Datenbank
  #die Eigenschaften aus "models/user" werden hier mit der Datenbank abgeglichen / verknüpft
  mapping do
    collection :tasks do
      entity     VirtualBrain::Models::Task    # Entität = InformationsOBJEKT / hier die Klasse, keine Instanz
      repository VirtualBrain::Repositories::TaskRepository

      attribute :id,   Integer
      attribute :name, String
      attribute :user_id, Integer
    end

    #Tabellennamen immer Mehrzal, deshalb users mit s
    #collection = mehrere, deshalb Mehrzahl
    collection :users do
      entity      VirtualBrain::Models::User
      repository  VirtualBrain::Repositories::UserRepository

      attribute :id,        Integer 
      attribute :email,     String
      attribute :password,  String
    end
  end
end

Lotus::Model.load!
end

def h(text)   # Methode, die die Eingabe von spitzen Klammern als Code verhindert
  Rack::Utils.escape_html(text)
end
