require "aphrodite/bot/face_detector/face"

module Aphrodite
  module Bot
    class FaceDetector < Olimpo::Base
      class Image

        def initialize(params)
          @faces = params['faces'].map { |face| Aphrodite::Bot::FaceDetector::Face.new(face) } if params["faces"].present?
          @resolved_url = params["resolved_url"]
          @source_url = params["source_url"]
          @image = params["image"]
          @error = Aphrodite::Bot::VisualRecognizer::ImageError.new(params["error"]) if params["error"].present?

          readable_attributes(params)
        end

        private

          def readable_attributes(params)
            return class_eval { attr_reader :error, :image } if params["error"].present?
            return class_eval { attr_reader :faces, :resolved_url, :source_url } if params["resolved_url"].present? && params["source_url"].present?
            return class_eval { attr_reader :faces, :image } if params["image"].present?
          end
      end
    end
  end
end
