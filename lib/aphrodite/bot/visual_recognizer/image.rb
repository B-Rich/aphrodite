require "aphrodite/bot/visual_recognizer/classifier"
require "aphrodite/bot/visual_recognizer/image_error"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Image
        def initialize(params)
          @classifiers = params['classifiers'].map { |classifier| Aphrodite::Bot::VisualRecognizer::Classifier.new(classifier) } if params["classifiers"].present?
          @resolved_url = params["resolved_url"]
          @source_url = params["source_url"]
          @image = params["image"]
          @error = Aphrodite::Bot::VisualRecognizer::ImageError.new(params["error"]) if params["error"].present?

          readable_attributes(params)
        end

        private

          def readable_attributes(params)
            return class_eval { attr_reader :error, :image } if params["error"].present?
            return class_eval { attr_reader :classifiers, :resolved_url, :source_url } if params["resolved_url"].present? && params["source_url"].present?
            return class_eval { attr_reader :classifiers, :image } if params["image"].present?
          end
      end
    end
  end
end
