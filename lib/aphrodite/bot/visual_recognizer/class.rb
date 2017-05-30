module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Class
        attr_reader :class_name, :score, :type_hierarchy

        def initialize(params)
          @class_name = params["class"]
          @score = params["score"]
          @type_hierarchy = params["type_hierarchy"]
        end
      end
    end
  end
end
