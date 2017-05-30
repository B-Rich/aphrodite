require "aphrodite/bot/face_detector/image"

module Aphrodite
  module Bot
    class FaceDetector
      class Response
        attr_reader :images, :images_processed

        def initialize(params)
          @images = params['images'].map { |image| Aphrodite::Bot::FaceDetector::Image.new(image) }
          @images_processed = params["images_processed"]
        end
      end
    end
  end
end
