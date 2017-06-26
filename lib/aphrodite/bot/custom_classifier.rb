require "aphrodite/bot/custom_classifier/get_classifiers_top_level_verbose"

module Aphrodite
  module Bot
    class CustomClassifier < Olimpo::Base
      def self.create(query = {}, formData = {})
        input_file = File.new(query[:file])
        response = post("/classifier?version=2016-05-20", query: query, formData: formData)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::GetClassifiersTopLevelVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end

      def self.all(query = {})
        response = get("/classifier?version=2016-05-20", query: query)

        parsed_response = JSON.parse(response.body)
        return Aphrodite::Bot::GetClassifiersTopLevelVerbose.new(parsed_response) if response.success?
        raise_exception(response.code, response.body)
      end
    end
  end
end
