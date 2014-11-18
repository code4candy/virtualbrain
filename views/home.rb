module VirtualBrain
  module Views
    module Home
      class Index
        include VirtualBrain::View

        def greeting
          if name
            "Hi #{name}!"
          else
            "Hi brainless!"
          end
        end

      end
    end
  end
end