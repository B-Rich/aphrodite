module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      class Class < Olimpo::Base
        attr_reader :single_class

        def initialize(single_class = {})
          @single_class = single_class["class"]
        end
      end
    end
  end
end
