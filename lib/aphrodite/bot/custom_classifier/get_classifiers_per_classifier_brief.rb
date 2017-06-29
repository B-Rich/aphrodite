module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      class GetClassifiersPerClassifierBrief
        attr_reader :classifier

        def initialize(classifier = {})
          @classifier_id = classifier["classifier_id"]
          @name = classifier["name"]
        end
      end
    end
  end
end
