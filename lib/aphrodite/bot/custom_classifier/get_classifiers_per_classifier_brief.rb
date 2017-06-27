module Aphrodite
  module Bot
    class GetClassifiersPerClassifierBrief < Olimpo::Base
      attr_reader :classifier

      def initialize(classifier = {})
        @classifier_id = classifier["classifier_id"]
        @name = classifier["name"]
      end
    end
  end
end
