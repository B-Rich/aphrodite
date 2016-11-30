require "aphrodite/bot/version"
require "olimpo"

module Aphrodite
  module Bot
    extend Olimpo
    autoload :VisualRecognizer, 'aphrodite/bot/visual_recognizer'
    autoload :FaceDetector, 'aphrodite/bot/face_detector'
  end
end
