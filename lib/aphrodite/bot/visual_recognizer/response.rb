require "aphrodite/bot/visual_recognizer/image"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class Response
        attr_reader :custom_classes, :images, :images_processed

        def initialize(params)
          @custom_classes = params["custom_classes"]
          @images = params['images'].map { |image| Aphrodite::Bot::VisualRecognizer::Image.new(image) }
          @images_processed = params["images_processed"]
        end
      end
    end
  end
end
