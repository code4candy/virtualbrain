require 'lotus'
require 'lotus/model'

module VirtualBrain
  class Application < Lotus::Application
    configure do
      routes do
        # zeigt aus welcher Datei der Browserpfad seine Daten bekommen soll
        get '/', to: 'home#index' 
        post '/', to: 'home#index'
        get '/imprint', to: 'imprint#page'
      end

      load_paths << [
        'controllers',
        'models',
        'views',
        'repositories'
      ]
      layout :application
    end

    load!
  end
  CONNECTION_URI = "sqlite://#{ __dir__ }/test.db"

  Lotus::Model.configure do
  adapter type: :sql, uri: CONNECTION_URI

  mapping do
    collection :tasks do
      entity     VirtualBrain::Models::Task
      repository VirtualBrain::Repositories::TaskRepository

      attribute :id,   Integer
      attribute :name, String
    end
  end
end

Lotus::Model.load!
end
