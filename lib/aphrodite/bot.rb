require "aphrodite/bot/version"
require "olimpo"

module Aphrodite
  module Bot
    extend Olimpo
    autoload :VisualRecognizer, 'aphrodite/bot/visual_recognizer'
    autoload :FaceDetector, 'aphrodite/bot/face_detector'
    autoload :Classificator, 'aphrodite/bot/classificator'
    autoload :CustomClassifier, 'aphrodite/bot/custom_classifier'
  end
end
