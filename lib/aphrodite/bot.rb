require "aphrodite/bot/version"
require "olimpo"

module Aphrodite
  module Bot
    extend Olimpo
    autoload :VisualRecognizer, 'aphrodite/bot/visual_recognizer'
  end
end
