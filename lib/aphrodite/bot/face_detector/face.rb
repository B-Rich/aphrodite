module Aphrodite
  module Bot
    class FaceDetector < Olimpo::Base
      class Face
        attr_reader :age, :face_location, :gender

        def initialize(params)
          @age = Aphrodite::Bot::FaceDetector::Face::Age.new(params["age"])
          @face_location = Aphrodite::Bot::FaceDetector::Face::Location.new(params["face_location"])
          @gender = Aphrodite::Bot::FaceDetector::Face::Gender.new(params["gender"])
        end

        class Age
          attr_reader :max, :min, :score

          def initialize(params)
            @max = params["max"]
            @min = params["min"]
            @score = params["score"]
          end
        end

        class Location
          attr_reader :height, :left, :top, :width

          def initialize(params)
            @height = params["height"]
            @left = params["left"]
            @top = params["top"]
            @width = params["width"]
          end
        end

        class Gender
          attr_reader :gender, :score

          def initialize(params)
            @gender = params["gender"]
            @score = params["score"]
          end
        end

      end
    end
  end
end
