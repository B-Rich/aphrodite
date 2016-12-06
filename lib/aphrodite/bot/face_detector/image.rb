require "aphrodite/bot/face_detector/face"

module Aphrodite
  module Bot
    class FaceDetector < Olimpo::Base
      class Image
        attr_reader :faces, :resolved_url, :source_url

        def initialize(params)
          @faces = params['faces'].map { |face| Aphrodite::Bot::FaceDetector::Face.new(face) }
          @resolved_url = params["resolved_url"]
          @source_url = params["source_url"]
        end
      end
    end
  end
end
