require "aphrodite/bot/visual_recognizer/class"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Classifier
        attr_reader :classes, :classifier_id, :name

        def initialize(params)
          @classes = params['classes'].map { |klass| Aphrodite::Bot::VisualRecognizer::Class.new(klass) }
          @classifier_id = params["classifier_id"]
          @name = params["name"]
        end
      end
    end
  end
end
