require "aphrodite/bot/custom_classifier/get_classifiers_per_classifier_verbose"

module Aphrodite
  module Bot
    class GetClassifiersTopLevelVerbose < Olimpo::Base
      attr_reader :classifiers

      def initialize(attrs = {})
        @classifiers = []
        build_classifiers(attrs["classifiers"])
      end

      def build_classifiers(classifiers)
        classifiers.each do |classifier|
          @classifiers << Aphrodite::Bot::GetClassifiersPerClassifierVerbose.new(classifier)
        end
      end
    end
  end
end
