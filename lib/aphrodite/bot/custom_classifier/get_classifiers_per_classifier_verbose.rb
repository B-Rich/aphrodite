require "aphrodite/bot/custom_classifier/class"

module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      class GetClassifiersPerClassifierVerbose
        attr_reader :classifier

        def initialize(classifier = {})
          @classifier_id = classifier["classifier_id"]
          @name = classifier["name"]
          @owner = classifier["owner"]
          @status = classifier["status"]
          @explanation = classifier["explanation"]
          @created = classifier["created"]
          @classes = []
          build_classes(classifier["classes"]) if classifier["classes"] != nil
        end

        def build_classes(classes)
          classes.each do |single_class|
            @classes << Aphrodite::Bot::CustomClassifier::Class.new(single_class)
          end
        end
      end
    end
  end
end
