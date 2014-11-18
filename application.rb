require 'lotus'

module VirtualBrain
  class Application < Lotus::Application
    configure do
      routes do
        get '/', to: 'home#index'
      end

      load_paths << [
        'controllers',
        'models',
        'views'
      ]
      layout :application
    end

    load!
  end
end
