require "aphrodite/bot/face_detector/response"

module Aphrodite
  module Bot
    class FaceDetector < Olimpo::Base
      headers 'Content-Type' => 'application/json'

      def self.detect_from_url(params, options = {}, headers = {})
        response = get("/v3/detect_faces",
                        headers: default_face_detector_headers.merge(headers),
                        query: default_face_detector_options.merge(params).merge(options))


        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::FaceDetector::Response.new(parsed_response) if response.success?

        raise_exception(response.code, response.body)
      end

      def self.detect(params, options = {}, headers = {})
        response = post("/v3/detect_faces",
                        body: params,
                        headers: default_face_detector_headers.merge(headers),
                        query: default_face_detector_options.merge(options))

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::FaceDetector::Response.new(parsed_response) if response.success?

        raise_exception(response.code, response.body)
      end

      def self.default_face_detector_options
        {
          version: "2016-09-20"
        }
      end

      def self.default_face_detector_headers
        {
          "Accept-Language" => "en"
        }
      end
    end
  end
end
