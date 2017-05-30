require "aphrodite/bot/visual_recognizer/class"

module Aphrodite
  module Bot
    class VisualRecognizer < Olimpo::Base
      class ImageError
        attr_reader :description, :error_id

        def initialize(params)
          @description = params['description']
          @error_id = params["error_id"]
        end
      end
    end
  end
end
