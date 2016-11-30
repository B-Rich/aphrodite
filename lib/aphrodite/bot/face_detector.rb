module Aphrodite
  module Bot
    class FaceDetector < Olimpo::Base
      headers 'Content-Type' => 'application/json'

      def self.detect_by_url(params, options = {}, headers = {})
        response = get("/v3/detect_faces",
                        headers: default_visual_recognizer_headers.merge(headers),
                        query: default_visual_recognizer_options.merge(params).merge(options))



        parsed_response = JSON.parse(response.body)
        return parsed_response if response.success?

        raise_exception(response.code, response.body)
      end

      def self.detect(params, options = {}, headers = {})
        response = post("/v3/detect_faces",
                        body: params,
                        headers: default_visual_recognizer_headers.merge(headers),
                        query: default_visual_recognizer_options.merge(options))



        parsed_response = JSON.parse(response.body)
        return parsed_response if response.success?

        raise_exception(response.code, response.body)
      end

      private

        def self.default_visual_recognizer_options
          {
            version: "2016-09-20"
          }
        end

        def self.default_visual_recognizer_headers
          {
            "Accept-Language" => "en"
          }
        end
    end
  end
end
