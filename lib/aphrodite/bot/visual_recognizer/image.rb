require "aphrodite/bot/visual_recognizer/classifier"
require "aphrodite/bot/visual_recognizer/image_error"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Image
        attr_reader :classifiers, :resolved_url, :source_url

        attr_reader :image, :error

        def initialize(params)
          @classifiers = params['classifiers'].map { |classifier| Aphrodite::Bot::VisualRecognizer::Classifier.new(classifier) } if params["classifiers"].present?
          @resolved_url = params["resolved_url"]
          @source_url = params["source_url"]
          @image = params["image"]
          @error = Aphrodite::Bot::VisualRecognizer::ImageError.new(params["error"]) if params["error"].present?
        end
      end
    end
  end
end
