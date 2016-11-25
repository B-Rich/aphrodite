require "aphrodite/bot/visual_recognizer/classifier"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Image
        attr_reader :classifiers, :resolved_url, :source_url

        def initialize(params)
          @classifiers = params['classifiers'].map { |classifier| Aphrodite::Bot::VisualRecognizer::Classifier.new(classifier) }
          @resolved_url = params["resolved_url"]
          @source_url = params["source_url"]
        end
      end
    end
  end
end
