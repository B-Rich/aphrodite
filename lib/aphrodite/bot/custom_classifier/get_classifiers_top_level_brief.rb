require "aphrodite/bot/custom_classifier/get_classifiers_per_classifier_brief"

module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      class GetClassifiersTopLevelBrief
        attr_reader :classifiers

        def initialize(attrs = {})
          @classifiers = []
          build_classifiers(attrs["classifiers"])
        end

        def build_classifiers(classifiers)
          classifiers.each do |classifier|
            @classifiers << Aphrodite::Bot::CustomClassifier::GetClassifiersPerClassifierBrief.new(classifier)
          end
        end
      end
    end
  end
end